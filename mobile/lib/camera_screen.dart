import 'package:ankigen/display_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mecab_dart/mecab_dart.dart';

class CameraScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.high,
    );

    return _controller.initialize();
  }

  Future<void> _enableContinuousAutoFocus() async {
    try {
      await _controller.setFocusMode(FocusMode.auto);
    } catch (e) {
      print("Error enabling continuous autofocus: $e");
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentContext = context;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ankigen'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        children: [
          ElevatedButton(
            onPressed: () {
              _enableContinuousAutoFocus();
            },
            child: Text('Enable Continuous Autofocus'),
          ),
          FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: () async {
              try {
                await _initializeControllerFuture;
                final image = await _controller.takePicture();
                final inputImage = InputImage.fromFilePath(image.path);
                final textRecognizer =
                    TextRecognizer(script: TextRecognitionScript.japanese);
                final recognizedText =
                    await textRecognizer.processImage(inputImage);
                final tagger = Mecab();
                await tagger.init("assets/ipadic", true);
                final tokenizedText = tagger.parse(recognizedText.text);
                // If the picture was taken, display it on a new screen.
                await Navigator.of(currentContext).push(
                  MaterialPageRoute(
                    builder: (context) => DisplayImageScreen(
                      // Pass the automatically generated path to
                      // the DisplayPictureScreen widget.
                      imagePath: image.path,
                      tokenizedText: tokenizedText,
                    ),
                  ),
                );
              } catch (e) {
                print("Error taking picture: $e");
              }
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
