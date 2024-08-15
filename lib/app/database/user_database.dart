import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserFields {
  // Nome das Tabelas
  static const String gradesTableName = "grades";
  static const String addedCoursesTableName = "added_courses";
  static const String userDataTableName = "user_data";

  // Colunas
  static const String idColumnName = "id";
  static const String nameColumnName = "name";
  static const String courseCodeColumnName = "course_code";
  static const String gradeColumnName = "grade";
  static const String userYearColumnName = "year";
  static const String userGraduationColumnName = "graduation";
}

class UserDatabase {
  static final UserDatabase instance = UserDatabase._internal();

  static Database? _database;

  UserDatabase._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), "user.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute('''
        CREATE TABLE ${UserFields.userDataTableName} (
          ${UserFields.idColumnName} INTEGER PRIMARY KEY,
          ${UserFields.userGraduationColumnName} TEXT NOT NULL,
          ${UserFields.userYearColumnName} INTEGER
        )
    ''');
  }

  Future<UserModel?> getUserData() async {
    final db = await instance.database;
    final maps = await db.query(UserFields.userDataTableName);
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }
}
