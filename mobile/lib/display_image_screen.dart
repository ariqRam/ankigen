import 'dart:io';

import 'package:flutter/material.dart';

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;
  final String recognizedText;

  const DisplayImageScreen(
      {super.key, required this.imagePath, required this.recognizedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            Image.file(File(imagePath)),
            Text(recognizedText),
          ],
        ));
  }
}
