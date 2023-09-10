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
                  subtitle: Text(JMDict()
                      .search(keyword: widget.list.elementAt(index).surface)!
                      .first
                      .senseElements
                      .elementAt(0)
                      .toString()),
                );
              },
            );
          }),
    );
  }
}
