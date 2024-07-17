import 'package:dev_medias_front_flutter/app/model/counter.dart';
import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();

  @observable
  Counter counter = Counter(value: 0);

  @action
  void incrementCounter() {
    counter = Counter(value: counter.value + 1);
  }
}