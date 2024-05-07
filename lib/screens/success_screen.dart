import 'package:attendx/screens/qr_screen.dart';
import 'package:attendx/services/postGres_services.dart';
import 'package:flutter/material.dart';

class SuccessScreen extends StatefulWidget {
  final int day;
  const SuccessScreen({
    Key? key,
    required this.day,
  }) : super(key: key);

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  String value = particpiantIDfromPost.toString();
  String teamname = teamName.toString();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    print("Success screen");
    print(particpiantIDfromPost);
    print(teamName);
    print("printed participant id");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              "Attendance marked successfully!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 46,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Participant ID",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Team Name",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                teamname,
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "For Day",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                widget.day == 1
                    ? "Day 1"
                    : widget.day == 2
                        ? "Day 2"
                        : "Day 3",
                style: const TextStyle(
                  fontSize: 22,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const QrScreen(),
                  ));
                },
                child: Container(
                  width: 140,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 34, 122, 88),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Center(
                    child: Text(
                      "Done",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
