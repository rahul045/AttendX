import 'package:attendx/screens/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  //   Future.delayed(const Duration(seconds: 8), () {
  //     Navigator.of(context).pushReplacement(MaterialPageRoute(
  //       builder: (_) => const QrScreen(),
  //     ));
  //   });
  // }

  // @override
  // void dispose() {
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //       overlays: SystemUiOverlay.values);
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            right: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const QrScreen(),
                ));
              },
              child: Container(
                width: 315,
                height: 65,
                decoration: const BoxDecoration(
                  color: Colors.transparent
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
