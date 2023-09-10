import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mecab_dart/mecab_dart.dart';

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;
  final List<TokenNode> tokenizedText;

  const DisplayImageScreen(
      {super.key, required this.imagePath, required this.tokenizedText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            Image.file(File(imagePath)),
            SizedBox(
              height: 200,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tokenizedText.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(tokenizedText.elementAt(index).surface),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
