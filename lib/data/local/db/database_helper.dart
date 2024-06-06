import 'package:flutter_resto_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  DatabaseHelper.internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper.internal();

  static const String _tblFavorite = 'favorite';

  Future<Database> _initDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tblFavorite (
              id TEXT PRIMARY KEY,
              name TEXT,
              description TEXT,
              pictureId TEXT,
              city TEXT,
              rating DOUBLE
            )''',
        );
      },
      version: 2,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  Future<void> insertFavoriteResto(ListRestaurantItem restaurant) async {
    final db = await database;
    await db!.insert(_tblFavorite, restaurant.toJson());
  }

  Future<List<ListRestaurantItem>> getFavoriteResto() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);

    return results.map((res) => ListRestaurantItem.fromJson(res)).toList();
  }

  Future<Map?> getFavoriteRestoById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavoriteResto(String id) async {
    final db = await database;
    await db!.delete(
      _tblFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
