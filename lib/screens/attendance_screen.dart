import 'package:attendx/screens/id_screen.dart';
import 'package:attendx/screens/qr_screen.dart';
import 'package:attendx/screens/success_screen.dart';
import 'package:attendx/services/postGres_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AttendanceScreen extends StatefulWidget {
  final String code;
  const AttendanceScreen({
    Key? key,
    required this.code,
  }) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  int selectedDay = 1;
  bool isLoading = false;

  markAttendance() async {
    setState(() {
      isLoading = true;
    });
    print("Selected day: $selectedDay");
    selectedDay == 1
        ? await markAttendance1(widget.code)
        : selectedDay == 2
            ? await markAttendance2(widget.code)
            : await markAttendance3(widget.code);

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => SuccessScreen(
        day: selectedDay,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => const QrScreen(),
            ));
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
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text(
              "Choose Slot for attendance",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                color: Color.fromARGB(255, 235, 230, 230),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedDay = 1;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: selectedDay == 1
                            ? const Color.fromARGB(255, 34, 122, 88)
                            : const Color.fromARGB(255, 235, 230, 230),
                      ),
                      child: Text(
                        "Day 1",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: selectedDay == 1 ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // const Divider(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedDay = 2;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: selectedDay == 2
                            ? const Color.fromARGB(255, 34, 122, 88)
                            : const Color.fromARGB(255, 235, 230, 230),
                      ),
                      child: Text(
                        "Day 2",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color:
                                selectedDay == 2 ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                  // const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selectedDay = 3;
                      });
                    },
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: selectedDay == 3
                            ? const Color.fromARGB(255, 34, 122, 88)
                            : const Color.fromARGB(255, 235, 230, 230),
                      ),
                      child: Text(
                        "Day 3",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            color:
                                selectedDay == 3 ? Colors.white : Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          isLoading
              ? const CircularProgressIndicator(
                  color: Color.fromARGB(255, 34, 122, 88),
                )
              : Container(),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: markAttendance,
            child: Container(
              width: 200,
              height: 70,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 34, 122, 88),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: const Center(
                child: Text(
                  "Mark Attendance",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
