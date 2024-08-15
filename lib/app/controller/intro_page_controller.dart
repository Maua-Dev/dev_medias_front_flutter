import 'dart:async';
import 'package:dev_medias_front_flutter/app/database/user_database.dart';
import 'package:dev_medias_front_flutter/app/model/user.dart';
import 'package:mobx/mobx.dart';
part 'intro_page_controller.g.dart';

class IntroPageController = IntroPageControllerBase with _$IntroPageController;

abstract class IntroPageControllerBase with Store {
  IntroPageControllerBase();

  UserDatabase userDatabase = UserDatabase.instance;

  @observable
  bool userDataMissing = true;

  @action
  Future<bool> checkUserData() async {
    UserModel? data = await userDatabase.getUserData();
    if (data != null) userDataMissing = false;
    return userDataMissing;
  }
}

IntroPageController introPageController = IntroPageController();
