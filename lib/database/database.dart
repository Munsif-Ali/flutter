import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DataHelper {
  static Future<Database> database() async {
    final dataPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dataPath, 'image.db'),
        onCreate: (db, version) {
      return db
          .execute('CREATE TABLE user_image(id TEXT PRIMARY KEY, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DataHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DataHelper.database();
    return db.query(table);
  }
}
