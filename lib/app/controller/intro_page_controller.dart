import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:mobx/mobx.dart';
part 'intro_page_controller.g.dart';

class IntroPageController = IntroPageControllerBase with _$IntroPageController;

abstract class IntroPageControllerBase with Store {
  IntroPageControllerBase();

  @observable
  bool loggedIn = false;

  @action
  void setLoginSuccesful(bool status) {
    loggedIn = status;
  }

  @action
  Future<bool> checkUserDataExists() async {
    return await userController.checkUserDataExists();
  }

  // @action
  // Future<UserModel?> getUserData() async {
  //   UserModel? data = await userController.getUserData();
  //   return data;
  // }

  @action
  Future<void> insertUserData(UserModel user) async {
    userController.insertUserData(user);
  }
}

IntroPageController introPageController = IntroPageController();
