// ignore_for_file: depend_on_referenced_packages
import 'dart:io';
import 'package:face_detection_app/model/face_detector_model.dart';
import 'package:face_detection_app/utils/face_painter.dart';
import 'package:face_detection_app/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:ui' as ui;

class ChooseOrCapture extends StatefulWidget {
  const ChooseOrCapture({super.key});

  @override
  State<ChooseOrCapture> createState() => _ChooseOrCaptureState();
}

class _ChooseOrCaptureState extends State<ChooseOrCapture> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  List<Face> _faces = [];
  ui.Image? _imageUi;
  Future<void> chooseImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final File imageFile = File(image.path);
      await detectFaces(imageFile);
    }
  }

  Future<void> detectFaces(File imageFile) async {
    final faceDetectorModel = FaceDetectorModel();
    List<Face> faces = await faceDetectorModel.detectFaces(imageFile);
    setState(() {
      _image = imageFile;
      _faces = faces;
    });
    await loadImage(imageFile);
  }

  Future<void> loadImage(File file) async {
    final data = await file.readAsBytes();
    await decodeImageFromList(data).then((value) {
      setState(() {
        _imageUi = value;
      });
    });
  }

  Future<void> captureImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final File imageFile = File(photo.path);
      await detectFaces(imageFile);
    }
  }

  void clearImage() {
    setState(() {
      _image = null;
      _faces = [];
      _imageUi = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Face Recognition',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Faces Detected: ${_faces.length}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _image != null
                ? SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: _imageUi != null
                          ? FacePainter(_imageUi!, _faces)
                          : null,
                    ),
                  )
                : Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.image,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
            SizedBox(height: 20),
            CustomElevatedButton(
                text: 'Capture Image', onPressed: captureImage),
            SizedBox(height: 20),
            CustomElevatedButton(text: 'Choose Image', onPressed: chooseImage),
            SizedBox(height: 20),
            CustomElevatedButton(text: 'Clear Image', onPressed: clearImage),
          ],
        ),
      ),
    );
  }
}
