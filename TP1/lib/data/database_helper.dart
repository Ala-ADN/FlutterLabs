import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  DatabaseHelper._();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    _ensureDbFactoryInitialized();
    final databasesPath = await getDatabasesPath();
    final path = p.join(databasesPath, 'FDTP.db');
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS book(name TEXT, price INTEGER, image TEXT, userEmail TEXT)',
        );
        await db.execute(
          'CREATE TABLE IF NOT EXISTS user(email TEXT PRIMARY KEY, fullName TEXT)',
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Add userEmail column to book table for user association
          await db.execute('ALTER TABLE book ADD COLUMN userEmail TEXT');
        }
      },
    );
  }

  void _ensureDbFactoryInitialized() {
    // For desktop platforms, initialize sqflite FFI.
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
    // On Android/iOS, sqflite initializes databaseFactory automatically.
    // On Web, SQLite via sqflite is not supported; avoid calling openDatabase there.
  }

  Future<void> close() async {
    final db = _db;
    if (db != null && db.isOpen) {
      await db.close();
      _db = null;
    }
  }
}
