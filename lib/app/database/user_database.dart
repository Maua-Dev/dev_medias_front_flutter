import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserFields {
  // Nome das Tabelas
  static const String gradesTableName = "grades";
  static const String addedCoursesTableName = "added_courses";
  static const String userDataTableName = "user";

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
    // databaseFactory.deleteDatabase(path);
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
                CREATE TABLE courses (
                  code TEXT NOT NULL PRIMARY KEY,
                  name TEXT NOT NULL
                );
            ''');
      },
    );
  }

  Future<UserModel?> getCourse(String code) async {
    final db = await instance.database;
    final maps = await db.query("user_data");
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }

  Future<int?> createUser(UserModel user) async {
    final db = await instance.database;
    final id = await db.insert("user_data", user.toJson());
    return id;
  }
}
