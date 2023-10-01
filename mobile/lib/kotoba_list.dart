// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jm_dict_en/jm_dict_en.dart';
import 'package:mecab_dart/mecab_dart.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<File> copyAssetToFileSystem(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);

  final directory =
      await getTemporaryDirectory(); // or getApplicationDocumentsDirectory()
  final file = File('${directory.path}/my_asset.txt');

  return file.writeAsBytes(byteData.buffer.asUint8List());
}

class KotobaList extends StatefulWidget {
  final List<TokenNode> list;
  const KotobaList({super.key, required this.list});

  @override
  State<KotobaList> createState() => _KotobaListState();
}

class _KotobaListState extends State<KotobaList> {
  @override
  void initState() {
    super.initState();
  }

  Future<Dictionary> _initializeDict() async {
    final file = await copyAssetToFileSystem('assets/JMdict_e.xml');
    final contents = await file.readAsString();
    return Dictionary.fromXmlString(contents);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildItem(int index, Dictionary dict) {
      final gloss = (widget.list).map((word) => dict.search(word.surface));
      final entry = gloss.elementAt(index);

      return Text(entry.gloss.elementAtOrNull(0) ?? '');
    }

    return Scaffold(
      appBar: AppBar(title: const Text("List of Words")),
      body: FutureBuilder<Dictionary>(
          future: _initializeDict(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final dict = snapshot.data;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: widget.list.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    dense: true,
                    title: Text(widget.list.elementAt(index).surface),
                    subtitle: buildItem(
                      index,
                      dict!,
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
