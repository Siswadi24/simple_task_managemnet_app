import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DBHelperSignup {
  static Database? _dbSignup;
  static final int _version = 1;
  static final String _tableName = 'signup_table';
  // static final bool _isLogin = false;

  static Future<void> initDBSignUp() async {
    if (_dbSignup != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + '/signup.db';
      _dbSignup =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        print('DB SignUp Created');
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, name STRING, email STRING, password STRING, jenisKelamin STRING, isLogin INTEGER)',
        );
      });
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<int> insertSignUp(Map<String, dynamic> dataSignUp) async {
    print("Insert Function SignUp Called");
    debugPrint(dataSignUp.toString());
    return await _dbSignup?.insert(_tableName, dataSignUp) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> querySignUp() async {
    print("Query Function SignUp Called");
    return await _dbSignup!.query(_tableName);
  }

  //membuat fungsi login berdasarkan email dan password
  static Future<List<Map<String, dynamic>>> queryLogin(
      String email, String password) async {
    print(querySignUp().toString());
    print("Query Function Login Called");
    return await _dbSignup!.query(
      _tableName,
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
  }

  //membuat fungsi query berdasarkan jenis kelamin
  static Future<List<Map<String, dynamic>>> queryJK(String jenisKelamin) async {
    print("Query Function Called");
    return await _dbSignup!.query(_tableName,
        where: 'jenisKelamin = ?', whereArgs: [jenisKelamin]);
  }

  //membuat fungsi query berdasarkan id
  static Future<List<Map<String, dynamic>>> querySignUpById(int id) async {
    print("Query ID Function Called");
    return await _dbSignup!.query(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  //membuat fungsi logout
  static Future<void> logout() async {
    await _dbSignup!.update(_tableName, {'isLogin': 0});
  }
}
