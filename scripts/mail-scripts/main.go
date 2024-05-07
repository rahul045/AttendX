package main

import (
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"html"
	"html/template"
	"io/ioutil"
	"log"
	"os"

	"github.com/skip2/go-qrcode"
	"github.com/yuin/goldmark"
	meta "github.com/yuin/goldmark-meta"
	"github.com/yuin/goldmark/parser"
	"gopkg.in/gomail.v2"
)

type subscriberList struct {
	Subscribers []string `json:"subscribers"`
}

func main() {
	markdown := goldmark.New(
		goldmark.WithExtensions(
			meta.Meta,
		),
	)

	jsonFile, err := os.Open("emails.json")
	if err != nil {
		log.Print(err)
	}
	defer jsonFile.Close()

	byteValue, _ := ioutil.ReadAll(jsonFile)

	var list subscriberList
	json.Unmarshal(byteValue, &list)

	content, _ := ioutil.ReadFile("../../content/post/example.md")

	var buf bytes.Buffer
	context := parser.NewContext()
	if err := markdown.Convert(content, &buf, parser.WithContext(context)); err != nil {
		panic(err)
	}
	metaData := meta.Get(context)
	title := metaData["title"]
	str := fmt.Sprintf("%v", title)

	t := template.New("template.html")
	t, _ = t.ParseFiles("template.html")

	var body bytes.Buffer
	if err := t.Execute(&body, struct {
		Content string
		Title   string
	}{
		Content: buf.String(),
		Title:   str,
	}); err != nil {
		log.Println(err)
	}
	html := html.UnescapeString(body.String())

	emailToHash := make(map[string]string)
	for _, email := range list.Subscribers {
		// Use SHA-256 to hash the email
		hash := sha256.Sum256([]byte(email))
		// Convert the hash to a hex string
		hashHex := hex.EncodeToString(hash[:])
		// Store the email-to-hash mapping
		emailToHash[email] = hashHex
	}

	// Print the emailToHash map
	printEmailToHash(emailToHash)

	// Generate QR codes for each hash
	for email, hashHex := range emailToHash {
		fileName := fmt.Sprintf("./qrcodes/%s.png", hashHex)
		err := qrcode.WriteFile(hashHex, qrcode.Medium, 256, fileName)
		if err != nil {
			log.Printf("Failed to generate QR code for %s: %v", email, err)
		}
	}

	// Send emails with QR code attachments
	send(html, list.Subscribers, emailToHash)
}

func printEmailToHash(emailToHash map[string]string) {
	fmt.Println("Email-to-Hash Map:")
	for email, hash := range emailToHash {
		fmt.Printf("Email: %s, Hash: %s\n", email, hash)
	}
}

func send(body string, to []string, emailToHash map[string]string) {
	from := os.Getenv("MAIL_ID")
	pass := os.Getenv("MAIL_PASSWORD")

	d := gomail.NewDialer("smtp.gmail.com", 587, from, pass)
	s, err := d.Dial()
	if err != nil {
		panic(err)
	}

	bodyContent, err := ioutil.ReadFile("email_body.html")
	if err != nil {
		log.Fatal(err)
	}

	for _, r := range to {
		fmt.Printf("Sending email to: %s\n", r)
		m := gomail.NewMessage()
		m.SetHeader("From", from)
		m.SetAddressHeader("To", r, r)
		m.SetHeader("Subject", "OSDHACK '24 Attendance QR")
		m.SetBody("text/html", string(bodyContent))

		// Get the hash for the current email
		hashHex, ok := emailToHash[r]
		if ok {
			// Path to the QR code file
			qrFilePath := fmt.Sprintf("./qrcodes/%s.png", hashHex)
			// Attach the QR code file to the email and rename it to "qr.png"
			m.Attach(qrFilePath, gomail.Rename("qr.png"))
		} else {
			log.Printf("Could not find hash for email %q", r)
		}

		if err := gomail.Send(s, m); err != nil {
			log.Printf("Could not send email to %q: %v", r, err)
		}
		m.Reset()
	}
}
