import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();
}

HomePageController homeController = HomePageController();
