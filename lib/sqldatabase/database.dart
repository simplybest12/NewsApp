import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLhelper {
  static final _dbname = "mydatabasenews.db";
  static final _dbversion = 1;
  static final columnId = 'id';
  static final columnDescription = 'name';
  static final columntitle = 'title';
  static final tablename = "items";

  static Future<void> createTables(sql.Database database) async {
    await database.execute('''
    CREATE TABLE items(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
  
      title TEXT,
      description TEXT
      )
    
    ''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(_dbname, version: _dbversion,
        onCreate: (sql.Database database, int version) async {
      await createTables(database);
    });
  }

  static Future<int> createItem(String title, String description) async {
    final db = await SQLhelper.db();
    final data = {
      'title': title,
      'description': description,
    };
    final id = await db.insert('items', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    print("Successfully created");
    return id;
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLhelper.db();
    return db.query(tablename, orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLhelper.db();
    return db.query(tablename,
        where: "id=?",
        whereArgs: [id],
        limit: 1); //question mark ki vale arg me define hga
  }

  static Future<int> updateItem(
      int id, String title, String description) async {
    final db = await SQLhelper.db();
    final data = {
      "$columntitle": title,
      "$columnDescription": description,
    };
    final result =
        await db.update(tablename, data, where: 'id=?', whereArgs: [id]);
    return result;
  }

  static Future<void> deleteItem(int id) async {
    final db = await SQLhelper.db();
    try {
      await db.delete(tablename, where: 'id=?', whereArgs: [id]);
      print("Deleted");
    } catch (err) {
      debugPrint("Something went wrong when deleting an item : $err");
    }
  }
}
