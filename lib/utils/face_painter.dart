// ignore_for_file: depend_on_referenced_packages

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

class FacePainter extends CustomPainter {
  final ui.Image image;
  final List<Face> faces;

  FacePainter(this.image, this.faces);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.red;

    // Adjust the image size to fit inside the custom paint bounds
    final imageRect = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(
        image,
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
        imageRect,
        Paint());

    // Calculate scaling factor for bounding box
    double scaleX = size.width / image.width.toDouble();
    double scaleY = size.height / image.height.toDouble();

    // Draw the face bounding boxes
    for (var face in faces) {
      final boundingBox = face.boundingBox;

      final scaledBoundingBox = Rect.fromLTRB(
        boundingBox.left * scaleX,
        boundingBox.top * scaleY,
        boundingBox.right * scaleX,
        boundingBox.bottom * scaleY,
      );

      canvas.drawRect(scaledBoundingBox, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
