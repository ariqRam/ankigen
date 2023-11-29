import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class Entry {
  final int id;
  final String? reb;
  final String? keb;
  final List<String?> gloss;
  final List<String?> example;

  const Entry({
    required this.id,
    required this.gloss,
    required this.example,
    this.reb,
    this.keb,
  });
}

Future<String> getDatabasePath() async {
  var dbDir = await getApplicationDocumentsDirectory();
  var dbPath = join(dbDir.path, 'jmdict.db');

  // Check if the database exists
  if (!await File(dbPath).exists()) {
    // Should happen only the first time you launch your application
    print("Creating new copy from asset");

    // Copy from assets
    ByteData data = await rootBundle.load('databases/jmdict.db');
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await File(dbPath).writeAsBytes(bytes);
  } else {
    print("Opening existing database");
  }
  return dbPath;
}

Future<Database> initDatabase() async {
  var path = await getDatabasePath();
  return await openDatabase(path, version: 1);
}

Future<List<Entry>> entries() async {
  // Get a reference to the database.
  final db = await initDatabase();
  final List<Map<String, dynamic>> maps = await db.query('entry');

  print(json.decode(maps[0]['gloss']));
  return List.generate(maps.length, (i) {
    return Entry(
      id: maps[i]['id'] as int,
      reb: maps[i]['reb'] as String?,
      keb: maps[i]['keb'] as String?,
      gloss: (json.decode(maps[i]['gloss']) as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
      example: (json.decode(maps[i]['example']) as List<dynamic>)
          .map((e) => e as String?)
          .toList(),
    );
  });
}
