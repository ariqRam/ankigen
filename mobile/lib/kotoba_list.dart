// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:jm_dict/jm_dict.dart';
import 'package:mecab_dart/mecab_dart.dart';

class KotobaList extends StatefulWidget {
  final List<TokenNode> list;
  const KotobaList({super.key, required this.list});

  @override
  State<KotobaList> createState() => _KotobaListState();
}

class _KotobaListState extends State<KotobaList> {
  late Future<void> _dict;

  @override
  void initState() {
    super.initState();
    _dict = _initializeDict();
  }

  Future<void> _initializeDict() async {
    return JMDict().initFromAsset(assetPath: "assets/JMdict.gz");
  }

  @override
  Widget build(BuildContext context) {
    final gloss = widget.list.map(
      (word) => {JMDict().search(keyword: word.surface, limit: 1)},
    );

    Widget buildItem(int index) {
      final element = gloss.elementAt(index);
      if (element != null && element.isNotEmpty) {
        final firstElement = element.first;
        if (firstElement != null && firstElement.isNotEmpty) {
          final firstSenseElement = firstElement.first;
          if (firstSenseElement != null) {
            final sense = firstSenseElement.senseElements;
            if (sense != null && sense.isNotEmpty) {
              final glossaries = sense.first.glossaries;
              if (glossaries != null && glossaries.isNotEmpty) {
                final text = glossaries.first.text;
                if (text != null) {
                  return Text(text);
                }
              }
            }
          }
        }
      }
      return Text("Not Found");
    }

    return Scaffold(
      appBar: AppBar(title: const Text("List of Words")),
      body: FutureBuilder<void>(
          future: _dict,
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: widget.list.length,
              itemBuilder: (context, index) {
                return ListTile(
                  dense: true,
                  title: Text(widget.list.elementAt(index).surface),
                  subtitle: buildItem(index),
                );
              },
            );
          }),
    );
  }
}
