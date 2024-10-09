import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  UserControllerBase();

  @observable
  bool userDataMissing = false;

  @observable
  bool firstLogin = true;

  @observable
  String? name = '';

  @observable
  String? graduation = '';

  @observable
  int? year = 0;

  @action
  String? getName() {
    return name;
  }

  @action
  String? getGraduation() {
    return graduation;
  }

  @action
  int? getYear() {
    return year;
  }

  @action
  void setName(String name) {
    this.name = name;
  }

  @action
  void setGraduation(String graduation) {
    this.graduation = graduation;
  }

  @action
  void setYear(int year) {
    this.year = year;
  }

  @observable
  ObservableList<String> currentCourses = ObservableList<String>.of([]);

  @action
  void setFirstLogin(bool status) {
    firstLogin = status;
  }

  @action
  Future<bool> checkUserDataExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userDataMissing = true;
    name = prefs.getString("name");
    graduation = prefs.getString("graduation");
    year = prefs.getInt("year");
    if (name != null && graduation != null && year != null) {
      setFirstLogin(false);
      userDataMissing = false;
    }
    return userDataMissing;
  }

  @action
  Future<UserModel?> getUserData() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    UserModel? user;
    final name = prefs.getString("name");
    final graduation = prefs.getString("graduation");
    final year = prefs.getInt("year");
    if (name != null && graduation != null && year != null) {
      user = UserModel(name: name, graduation: graduation, year: year);
    }
    return user;
  }

  @action
  Future<void> insertUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("name", user.name);
    prefs.setString("graduation", user.graduation);
    prefs.setInt("year", user.year);
    setName(user.name);
    setGraduation(user.graduation);
    setYear(user.year);
  }

  @action
  Future<void> resetUserData() async {
    SharedPreferences prefs;
    await Hive.initFlutter();
    prefs = await SharedPreferences.getInstance();
    Box box = await Hive.openBox('user');
    prefs.clear();
    List<String> courseList = [];
    box.put('currentCourses', courseList);
  }

  @action
  Future<void> getCurrentCourses() async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    currentCourses = ObservableList<String>.of(
        box.get('currentCourses', defaultValue: <String>[]));
  }

  @action
  Future<void> insertCurrentCourses(String code) async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    List<String> courseList =
        box.get('currentCourses', defaultValue: <String>[]);
    courseList.add(code);
    currentCourses = ObservableList<String>.of(courseList);
    box.put('currentCourses', courseList);
  }

  @action
  Future<void> removeCurrentCourse(String code) async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    List<String> courseList =
        box.get('currentCourses', defaultValue: <String>[]);
    courseList.remove(code);
    currentCourses = ObservableList<String>.of(courseList);
    box.put('currentCourses', courseList);
  }

  @action
  Future<void> loadInitialCourses(String code, int year) async {
    code = code.split(" ")[0];
    coursesController.allCourses?.forEach((key, value) async {
      if (value.courses.containsKey(code)) {
        if (value.courses[code] == year) {
          await insertCurrentCourses(key);
        }
      }
    });
  }
}

UserController userController = UserController();
