import 'package:news_app/src/models/item_model.dart';
import 'package:news_app/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "items.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
      CREATE TABLE Items 
      (
        id INTEGER PRIMARY KEY,
        type TEXT,
        by TEXT,
        time INTEGER,
        text INTEGER,
        parent INTEGER,
        kids BLOB,
        dead INTEGER,
        deleted INTEGER,
        url TEXT,
        score INTEGER,
        title TEXT,
        descendants INTEGER
      )
""");
    });
  }

  @override
  Future<ItemModel?> fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel? item) {
    return db.insert(
      "Items",
      item!.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  // Todo - to fetch top ids

  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }

  @override
  Future<int> clear() {
    return db.delete("Items");
  }
}

final newsDbProvider = NewsDbProvider();
