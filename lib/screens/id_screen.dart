import 'package:attendx/screens/attendance_screen.dart';
import 'package:attendx/screens/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IdScreen extends StatefulWidget {
  const IdScreen({Key? key}) : super(key: key);

  @override
  State<IdScreen> createState() => _IdScreenState();
}

class _IdScreenState extends State<IdScreen> {
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
                image: AssetImage("assets/idCard.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 170,
            right: 90,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const AttendanceScreen(),
                ));
              },
              child: Container(
                width: 170,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const QrScreen(),
                ));
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
