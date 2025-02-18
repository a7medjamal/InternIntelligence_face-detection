import 'package:face_detection_app/choose_or_capture.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FaceDetection());
}

class FaceDetection extends StatelessWidget {
  const FaceDetection({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChooseOrCapture(),
    );
  }
}
