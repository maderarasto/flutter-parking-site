import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static const _name = 'parking_site.db';
  static const _version = 1;

  LocalDB._();
  static final LocalDB db = LocalDB._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database ??= await _initDatabase();
    return _database!;
  }

  Future<List<Map<String, dynamic>>> get(String tableName,
      {String whereSql = '', List parameters = const []}) async {
    final db = await database;

    return await db.rawQuery('''
      SELECT * FROM $tableName ${whereSql != '' ? ' WHERE $whereSql' : ''}
    ''', parameters);
  }

  Future<void> insert(String tableName, Map<String, dynamic> object) async {
    final db = await database;

    await db.insert(tableName, object,
        conflictAlgorithm: ConflictAlgorithm.fail);
  }

  Future<Database> _initDatabase() async {
    String dbPath = join(await getDatabasesPath(), LocalDB._name);
    return await openDatabase(dbPath,
        version: LocalDB._version, onCreate: _onCreateDB);
  }

  _onCreateDB(Database db, int version) async {
    await db.transaction((txn) async {
      txn.execute('''
        CREATE TABLE IF NOT EXISTS sectors (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          letter TEXT NOT NULL,
          type TEXT NOT NULL,
          created_at TEXT NOT NULL)
        ''');
      txn.execute('''
        CREATE TABLE IF NOT EXISTS queue_times (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          duration REAL NOT NULL,
          created_at TEXT NOT NULL)
        ''');
      txn.execute('''
        CREATE TABLE IF NOT EXISTS departures (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          type TEXT NOT NULL,
          created_at TEXT NOT NULL)
        ''');
    });
  }
}
