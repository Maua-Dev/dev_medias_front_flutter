import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class UserService {

  // Future<bool> checkUserDataExists() async {
  //   await Hive.initFlutter();
  //   final userBox = await Hive.openBox('user');
  //   userDataMissing = true;
  //   name = prefs.getString("name");
  //   graduation = prefs.getString("graduation");
  //   year = prefs.getInt("year");
  //   if (name != null && graduation != null && year != null) {
  //     setFirstLogin(false);
  //     userDataMissing = false;
  //   }
  //   return userDataMissing;
  // }


  Future<Map> getUserData() async {
    await Hive.initFlutter();
    final userBox = await Hive.openBox('user');
    String? name = userBox.get('name', defaultValue: null);
    String? graduation = userBox.get('graduation', defaultValue: null);
    int? year = userBox.get('year', defaultValue: null);
    if (name != null && graduation != null && year != null) {
      return {
        'user': {
          'name': name,
          'graduation': graduation,
          'year': year
        }
      };
    }
    return {'error': 'User data is missing'};
  }

  Future<void> insertUserData(UserModel user) async {
    await Hive.initFlutter();
    final userBox = await Hive.openBox('user');
    userBox.put("name", user.name);
    userBox.put("graduation", user.graduation);
    userBox.put("year", user.year);
  }

  Future<void> resetUserData() async {
    await Hive.initFlutter();
    final userBox = await Hive.openBox('user');
    userBox.deleteAll(['name', 'graduation', 'year', 'currentCourses']);
  }

  Future<Map<String, List<String>>> getCurrentCourses() async {
    await Hive.initFlutter();
    final userBox = await Hive.openBox('user');
    List<String> courseList = userBox.get('currentCourses', defaultValue: <String>[]);
    return {'currentCourses': courseList};
  }


  Future<Map> insertCurrentCourses(String code) async {
    await Hive.initFlutter();
    final userBox = await Hive.openBox('user');
    List<String> courseList =
        userBox.get('currentCourses', defaultValue: <String>[]);
    courseList.add(code);
    userBox.put('currentCourses', courseList);
    return {'currentCourses': courseList};
  }


  Future<Map> removeCurrentCourse(String code) async {
    await Hive.initFlutter();
    var userBox = await Hive.openBox('user');
    List<String> courseList =
        userBox.get('currentCourses', defaultValue: <String>[]);
    courseList.remove(code);
    userBox.put('currentCourses', courseList);
    return {'currentCourses': courseList};
  }
}
