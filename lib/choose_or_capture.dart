import 'package:flutter/material.dart';

class ChooseOrCapture extends StatefulWidget {
  const ChooseOrCapture({super.key});

  @override
  State<ChooseOrCapture> createState() => _ChooseOrCaptureState();
}

class _ChooseOrCaptureState extends State<ChooseOrCapture> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose or Capture"),
      ),
    );
  }
}