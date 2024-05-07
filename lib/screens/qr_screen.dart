import 'dart:ffi';

import 'package:attendx/screens/id_screen.dart';
import 'package:attendx/screens/login_screen.dart';
import 'package:attendx/services/postGres_services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<QrScreen> createState() => _QrScreenState();
}

String imageURL = "";
const bgColor = Color(0xfffafafa);

class _QrScreenState extends State<QrScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanCompleted = false;
  bool isFrontCamera = false;
  bool isFlashOn = false;
  CameraController? _controller;
  late bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  void closeScreen() {
    isScanCompleted = false;
  }

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
        backgroundColor: bgColor,
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
          actions: [
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.flash_on,
                color: isFlashOn ? Colors.yellow : Colors.black,
              ),
              iconSize: 32.0,
              onPressed: () {
                setState(() {
                  isFlashOn = !isFlashOn;
                });
                cameraController.toggleTorch();
              },
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.flip_camera_android,
                color: isFrontCamera ? Colors.blue : Colors.black,
              ),
              iconSize: 32.0,
              onPressed: () {
                setState(() {
                  isFrontCamera = !isFrontCamera;
                });
                cameraController.switchCamera();
              },
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Place the QR code in the area",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Scanning will be started automatically",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      allowDuplicates: true,
                      onDetect: (barcode, args) {
                        if (!isScanCompleted) {
                          String code = barcode.rawValue ?? '---';
                          isScanCompleted = true;
                          // sendCodeToPost(code);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IdScreen(
                                code: code,
                                closeScreen: closeScreen,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    QRScannerOverlay(
                      overlayColor: bgColor,
                      scanAreaHeight: 250,
                      scanAreaWidth: 250,
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: Text("Welcome to OSDHack by OSDC"),
              ),
            ],
          ),
        )

        // Stack(S
        //   children: [
        //     Container(
        //       height: MediaQuery.of(context).size.height,
        //       width: MediaQuery.of(context).size.width,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: _isFlashOn ? const AssetImage("assets/qr_screen2.png") : const AssetImage("assets/qrscreen.png") ,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 20,
        //       right: 20,
        //       child: InkWell(
        //         onTap: () {
        //           Navigator.of(context).pushReplacement(MaterialPageRoute(
        //             builder: (_) => const IdScreen(),
        //           ));
        //         },
        //         child: Container(
        //           width: 100,
        //           height: 50,
        //           decoration: const BoxDecoration(
        //             color: Colors.transparent
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 20,
        //       left: 20,
        //       child: InkWell(
        //         onTap: () {
        //           Navigator.of(context).pushReplacement(MaterialPageRoute(
        //             builder: (_) => const LoginPage(),
        //           ));
        //         },
        //         child: Container(
        //           width: 100,
        //           height: 50,
        //           decoration: const BoxDecoration(
        //             color: Colors.transparent
        //           ),
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       bottom: 175,
        //       left: 145,
        //       child: InkWell(
        //         onTap: toggleFlashlight,
        //         child: Container(
        //           width: 80,
        //           height: 40,
        //           decoration: const BoxDecoration(
        //             color: Colors.transparent
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
