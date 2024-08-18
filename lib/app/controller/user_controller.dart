import 'dart:async';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_controller.g.dart';

class UserController = UserControllerBase with _$UserController;

abstract class UserControllerBase with Store {
  UserControllerBase();

  @observable
  bool userDataMissing = false;

  @observable
  String? name = '';

  @observable
  String? graduation = '';

  @observable
  int? year = 0;

  @action
  Future<bool> checkUserDataExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userDataMissing = true;
    name = prefs.getString("name");
    graduation = prefs.getString("graduation");
    year = prefs.getInt("year");
    if (name != null && graduation != null && year != null) {
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
  }

  @action
  Future<void> resetUserData() async {
    SharedPreferences prefs;
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

UserController userController = UserController();
