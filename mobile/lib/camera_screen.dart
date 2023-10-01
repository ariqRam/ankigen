import 'package:ankigen/display_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
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

  XFile? _image;

  Future<void> _getImage(currentContext) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });

    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.japanese);
      final recognizedText = await textRecognizer.processImage(inputImage);
      final tagger = Mecab();
      await tagger.init("assets/ipadic", true);
      final tokenizedText = tagger.parse(recognizedText.text);
      tokenizedText.forEach((element) {
        print("element: " + element.surface);
      });
      await Navigator.of(currentContext).push(
        MaterialPageRoute(
          builder: (context) => DisplayImageScreen(
            // Pass the automatically generated path to
            // the DisplayPictureScreen widget.
            imagePath: _image!.path,
            tokenizedText: tokenizedText,
          ),
        ),
      );
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    return _controller.initialize();
  }

  Future<void> onTap(TapDownDetails details, BoxConstraints constraints) async {
    final camera = _controller;
    if (!camera.value.isInitialized) {
      return;
    }
    final x = details.localPosition.dx / constraints.maxWidth;
    final y = details.localPosition.dy / constraints.maxHeight;
    final point = Offset(x, y);
    print(point);
    await camera.lockCaptureOrientation();
    await camera.setFocusPoint(point);
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
            return LayoutBuilder(
              builder: (context, constraints) {
                return GestureDetector(
                  onTapDown: (details) => onTap(details, constraints),
                  child: CameraPreview(_controller),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Row(
        children: [
          FloatingActionButton(
            child: Icon(Icons.camera),
            onPressed: () => {_capturePic(currentContext)},
          ),
          FloatingActionButton(
            onPressed: () => {_getImage(currentContext)},
            tooltip: 'Pick Image',
            child: Icon(Icons.add_a_photo),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _capturePic(currentContext) async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer =
          TextRecognizer(script: TextRecognitionScript.japanese);
      final recognizedText = await textRecognizer.processImage(inputImage);
      final tagger = Mecab();
      await tagger.init("assets/ipadic", true);
      final tokenizedText = tagger.parse(recognizedText.text);
      tokenizedText.forEach((element) {
        print(element.surface);
      });
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
  }
}
