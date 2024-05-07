import 'package:attendx/screens/qr_screen.dart';
import 'package:attendx/services/postGres_services.dart';
import 'package:attendx/widgets/submit_button.dart';
import 'package:attendx/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void signInUser() {
    if (emailController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text("Error!"),
          content: Text("Please enter your Email."),
        ),
      );
    } else if (passwordController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
          title: Text("Error!"),
          content: Text("Please enter your password."),
        ),
      );
    } else {
      setState(() {
        isLoading = true;
      });
      connectWithPost();
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => const QrScreen(),
        ));
      });
    }
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 2, child: Container()),
                Image.asset(
                  "assets/log_2.png",
                  height: 250,
                  width: 300,
                ),
                const SizedBox(
                  height: 40,
                ),
                TextFieldInput(
                    icon: LineAwesomeIcons.envelope,
                    textEditingController: emailController,
                    hintText: "Enter your email",
                    textInputType: TextInputType.emailAddress),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  icon: LineAwesomeIcons.lock,
                  textEditingController: passwordController,
                  hintText: "Enter your password",
                  textInputType: TextInputType.text,
                  isPass: true,
                ),
                const SizedBox(
                  height: 35,
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  text: "Log In",
                  onTap: signInUser,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
