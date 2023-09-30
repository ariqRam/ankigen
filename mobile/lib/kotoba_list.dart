// ignore_for_file: unnecessary_null_comparison

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:jm_dict_en/jm_dict_en.dart';
import 'package:mecab_dart/mecab_dart.dart';

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
    final file = File("assets/JMdict_e.xml");
    final contents = await file.readAsString();
    return Dictionary.fromXmlString(contents);
  }

  @override
  Widget build(BuildContext context) {
    Widget buildItem(int index, Dictionary dict) {
      final gloss = (widget.list).map((word) => dict.search(word.surface));
      final entry = gloss.elementAt(index);

      return Text(entry.gloss.first);
    }

    return Scaffold(
      appBar: AppBar(title: const Text("List of Words")),
      body: FutureBuilder<void>(
          future: _initializeDict(),
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  title: Text(widget.list.elementAt(index).surface),
                  subtitle: buildItem(
                      index, Dictionary.fromXmlString("assets/JMdict.xml")),
                );
              },
            );
          }),
    );
  }
}
