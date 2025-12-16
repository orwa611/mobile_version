import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../exceptions/app_data_base_exception.dart';

abstract class AppDataBase {
  Future<void> initialDb();
  Future<int> insert(String table, Map<String, Object?> values);
  Future<List<Map<String, Object?>>> query(String table);
  Future<int> delete(String table, {required Map<String, dynamic> where});
}

final class AppDataBaseImpl implements AppDataBase {
  late Database? database;

  @override
  Future<void> initialDb() async {
    try {
      String databasePath = await getDatabasesPath();
      String path = join(databasePath, 'fav.db');
      database = await openDatabase(path, onCreate: _onCreate, version: 2);
      print(" database Opened Success");
    } catch (e) {
      print("Can't open database ${e.toString()}");
      throw DataBaseNotFoundException();
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE "article" (
        "id" TEXT NOT NULL,
        "title" TEXT,
        "content" TEXT,
        "article_image" TEXT,
        "created_at" TEXT,
        "author_id" TEXT,
        "author_first_name" TEXT,
        "author_last_name" TEXT,
        "author_image" TEXT,
        PRIMARY KEY (id)
      )
  ''');
  }

  @override
  Future<int> insert(String table, Map<String, Object?> values) async {
    try {
      if (database != null) {
        return await database!.insert(table, values);
      } else {
        throw DataBaseNotFoundException();
      }
    } on AppDataBaseException catch (_) {
      rethrow;
    } catch (e) {
      throw DataBaseInsertionException();
    }
  }

  @override
  Future<List<Map<String, Object?>>> query(String table) async {
    try {
      if (database != null) {
        return await database!.query(table);
      } else {
        throw DataBaseNotFoundException();
      }
    } on AppDataBaseException catch (_) {
      rethrow;
    } catch (e) {
      throw DataBaseQueryException();
    }
  }

  @override
  Future<int> delete(
    String table, {
    required Map<String, dynamic> where,
  }) async {
    final String keyString = where.keys.map((key) => '$key = ?').join(' AND ');
    final List<dynamic> values = where.values.toList();
    try {
      if (database != null) {
        return await database!.delete(
          table,
          where: keyString,
          whereArgs: values,
        );
      } else {
        throw DataBaseNotFoundException();
      }
    } on AppDataBaseException catch (_) {
      rethrow;
    } catch (e) {
      throw DataBaseDaletionException(where);
    }
  }
}
