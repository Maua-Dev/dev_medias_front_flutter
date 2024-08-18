import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/user_controller.dart';
import 'package:dev_medias_front_flutter/app/database/user_database.dart';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:mobx/mobx.dart';
part 'intro_page_controller.g.dart';

class IntroPageController = IntroPageControllerBase with _$IntroPageController;

abstract class IntroPageControllerBase with Store {
  IntroPageControllerBase();

  UserDatabase userDatabase = UserDatabase.instance;

  @observable
  bool loggedIn = false;

  @action
  void setLoginSuccesful(bool status) {
    loggedIn = status;
  }
  //NÂO ESQUECER

  @action
  Future<bool> checkUserDataExists() async {
    // UserModel? data = await getUserData();
    // if (data == null) userDataMissing = true;
    return await userController.checkUserDataExists();
  }

  @action
  Future<UserModel?> getUserData() async {
    UserModel? data = await userController.getUserData();
    return data;
  }

  @action
  Future<void> insertUserData(UserModel user) async {
    // final id = await userDatabase.createUser(user);
    // print(id);
    userController.insertUserData(user);
  }
}

IntroPageController introPageController = IntroPageController();
