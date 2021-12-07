import 'package:consignt/core/model/search_history.dart';
import 'package:sqflite/sqflite.dart';

class SearchHistoryDatabaseHelper {
  static SearchHistoryDatabaseHelper? _instance;
  static Database? _database;
  static const String _tblSearchHistory = 'searchHistory';

  factory SearchHistoryDatabaseHelper() =>
      _instance ?? SearchHistoryDatabaseHelper._internal();

  SearchHistoryDatabaseHelper._internal() {
    _instance = this;
  }

  Future<List<SearchHistoryModel>> getSearchHistory() async {
    final db = await database;
    List<Map<String, Object?>> results =
        await db!.query(_tblSearchHistory, orderBy: 'id DESC');

    return results.map((res) => SearchHistoryModel.fromJson(res)).toList();
  }

  Future<void> addSearchHistory(SearchHistoryModel searchHistoryModel) async {
    final db = await database;
    await db!.insert(_tblSearchHistory, searchHistoryModel.toJson());
  }

  Future<void> deleteSearchHistory(int id) async {
    final db = await database;
    await db!.delete(
      _tblSearchHistory,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/consignt.db',
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE $_tblSearchHistory (
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        searchQuery TEXT NOT NULL
        )''');
      },
      version: 1,
    );
    return db;
  }
}
