import 'package:attendx/screens/id_screen.dart';
import 'package:attendx/screens/login_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key, }) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  CameraController? _controller;
  late bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      print('No cameras available');
      return;
    }
    _controller = CameraController(cameras[0], ResolutionPreset.low);
    await _controller!.initialize();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

 Future<void> toggleFlashlight() async {
  try {
    if (_controller == null) {
      // Controller is not yet initialized
      return;
    }
    if (_isFlashOn) {
      await _controller!.setFlashMode(FlashMode.off);
    } else {
      await _controller!.setFlashMode(FlashMode.torch);
    }
    setState(() {
      _isFlashOn = !_isFlashOn;
    });
  } catch (e) {
    print('Error toggling flashlight: $e');
  }
}
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: _isFlashOn ? const AssetImage("assets/qr_screen2.png") : const AssetImage("assets/qrscreen.png") ,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
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
                  color: Colors.transparent
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
                  builder: (_) => const LoginPage(),
                ));
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.transparent
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 175,
            left: 145,
            child: InkWell(
              onTap: toggleFlashlight,
              child: Container(
                width: 80,
                height: 40,
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