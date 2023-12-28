import 'package:flutter/material.dart';
import 'package:newankigen/classes/entry.dart';

class EntryCard extends StatelessWidget {
  const EntryCard({super.key, required this.entry});

  final Entry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(entry.keb ?? entry.reb ?? '')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            Text(
              (entry.keb ?? '') + (entry.reb != null ? '(${entry.reb})' : ''),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            for (var g in entry.gloss) Text(g ?? ''),
            for (var e in entry.example) Text(e ?? ''),
          ]),
        ));
  }
}
