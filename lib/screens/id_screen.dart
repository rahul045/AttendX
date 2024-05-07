import 'package:attendx/screens/attendance_screen.dart';
import 'package:attendx/screens/qr_screen.dart';
import 'package:attendx/screens/success_screen.dart';
import 'package:attendx/services/postGres_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class IdScreen extends StatefulWidget {
  final String code;
  final Function() closeScreen;
  const IdScreen({
    Key? key,
    required this.code,
    required this.closeScreen,
  }) : super(key: key);

  @override
  State<IdScreen> createState() => _IdScreenState();
}

class _IdScreenState extends State<IdScreen> {
  String imageURL = "";

  Future<void> sendCodeToPostgres(String code) async {
    String fileId = "";
    final string = await sendCodeToPost(code);
    print(string);
    final splitStrings = string.split('=');
    if (splitStrings.length > 1) {
      setState(() {
        fileId = splitStrings[1];
        imageURL = "https://drive.google.com/uc?export=view&id=$fileId";
        print(imageURL);
      });
    } else {
      setState(() {
        fileId = "";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    sendCodeToPostgres(widget.code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            widget.closeScreen();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const QrScreen(),
              ),
            );
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black87,
          ),
        ),
        centerTitle: true,
        title: const Text(
          "AttendX",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // QrImageView(
            //   data: "",
            //   size: 150,
            //   version: QrVersions.auto, // This will be set dynamically
            // ),
            const Text(
              "Participant ID",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            imageURL.isEmpty
                ? const CircularProgressIndicator()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: NetworkImage(
                        imageURL,
                      ),
                    ),
                  ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      connectWithPost();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => AttendanceScreen(code: widget.code,),
                      ));
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Center(
                        child: Text(
                          "Approve",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      connectWithPost();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (_) => const QrScreen(),
                      ));
                    },
                    child: Container(
                      width: 120,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                       child: const Center(
                        child: Text(
                          "Decline",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
