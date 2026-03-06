import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/restaurant.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance ??= DatabaseHelper._internal();

  Future<Database> get database async {
    _database ??= await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), 'restaurant.db');
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE favorite (
          id TEXT PRIMARY KEY,
          name TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
        )
      ''');
    });
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db.insert(
      'favorite',
      restaurant.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;
    await db.delete('favorite', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorite');
    return result.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final result =
        await db.query('favorite', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty;
  }
}
