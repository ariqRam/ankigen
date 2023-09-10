import 'dart:io';

import 'package:ankigen/kotoba_list.dart';
import 'package:flutter/material.dart';
import 'package:mecab_dart/mecab_dart.dart';

class DisplayImageScreen extends StatelessWidget {
  final String imagePath;
  final List<TokenNode> tokenizedText;

  const DisplayImageScreen(
      {super.key, required this.imagePath, required this.tokenizedText});

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
        appBar: AppBar(title: const Text('Display the Picture')),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Column(
          children: [
            Center(
              child: SizedBox(
                height: 650,
                child: Image.file(File(imagePath)),
              ),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.of(currentContext).push(
                  MaterialPageRoute(
                    builder: (context) => KotobaList(list: tokenizedText),
                  ),
                );
              },
              child: const Text("See Result"),
            ),
          ],
        ));
  }
}
