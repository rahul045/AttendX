import 'package:attendx/screens/qr_screen.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({Key? key, }) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  
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
                image: AssetImage("assets/success.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 150,
            right: 100,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const QrScreen(),
                ));
              },
              child: Container(
                width: 160,
                height: 55,
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