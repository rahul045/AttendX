import 'package:attendx/screens/id_screen.dart';
import 'package:attendx/screens/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
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
                image: AssetImage("assets/attendance.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: 55,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (_) => const SuccessScreen(),
                ));
              },
              child: Container(
                width: 250,
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
                  builder: (_) => const IdScreen(),
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
