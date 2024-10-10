import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:dev_medias_front_flutter/app/service/user_service.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  UserControllerBase();

  final UserService service = UserService();

  @observable
  bool userDataMissing = false;

  @computed
  bool get getUserDataMissing => userDataMissing;

  @action
  void setUserDataMissing(bool status) {
    userDataMissing = status;
  }

  @observable
  bool firstLogin = true;

  @computed
  bool get getFirstLogin => firstLogin;

  @action
  void setFirstLogin(bool status) {
    firstLogin = status;
  }

  @observable
  String? name = '';

  @observable
  String? graduation = '';

  @observable
  int? year = 0;

  @computed
  String? get getName => name;

  @computed
  String? get getGraduation => graduation;

  @computed
  int? get getYear => year;

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

  @computed
  List<String> get getCurrentCourses => currentCourses.toList();

  @action
  void setCurrentCourses(List<String> courses) {
    currentCourses = ObservableList<String>.of(courses);
  }

  @action
  Future<bool> checkUserDataExists() async {
    userDataMissing = true;
    final response = await service.getUserData();
    // verifica se o usuário existe
    if (response.containsKey('user')) {
      // firstLogin é true por padrão, ele muda para false se o usuário já existir
      setFirstLogin(false);
      userDataMissing = false;
    }
    return userDataMissing;
  }

  @action
  Future<Map> getUserData() async {
    return await service.getUserData();
  }

  @action
  Future<void> insertUserData(UserModel user) async {
    // Salva localmente os dados do usuário
    service.insertUserData(user);
    // Atualiza informações durante a sessão
    setName(user.name);
    setGraduation(user.graduation);
    setYear(user.year);
  }

  @action
  Future<void> resetUserData() async {
    await service.resetUserData();
  }

  @action
  Future<void> fetchCurrentCourses() async {
    final response = await service.getCurrentCourses();
    setCurrentCourses(ObservableList<String>.of(response['currentCourses']!.toList()));
  }

  @action
  Future<void> insertCurrentCourses(String code) async {
    final response = await service.insertCurrentCourses(code);
    setCurrentCourses(ObservableList<String>.of(response['currentCourses']!.toList()));
  }

  @action
  Future<void> removeCurrentCourse(String code) async {
    final response = await service.removeCurrentCourse(code);
    setCurrentCourses(ObservableList<String>.of(response['currentCourses']!.toList()));
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
