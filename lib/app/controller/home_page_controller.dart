import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();

  @action
  Future<String> getFinalScore(String courseCode) async {
      final grades = await gradeController.getGrades(courseCode);
      try {
        final result = grades['finalScore']['value'];
        return result.toString();
      } catch (e) {
        return 'N.A';
      }
  }
}

HomePageController homeController = HomePageController();
