import 'package:dev_medias_front_flutter/app/model/current_courses.dart';
import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();

  static var test_courses = [
    {
      "name": "Matéria 1",
      "desc": "Descrição da Matéria",
      "grade": "2.5",
    },
    {
      "name": "Matéria 2",
      "desc": "Descrição da Matéria",
      "grade": "6.5",
    },
    {
      "name": "Matéria 3",
      "desc": "Descrição da Matéria",
      "grade": "3.5",
    },
    {
      "name": "Matéria 4",
      "desc": "Descrição da Matéria",
      "grade": "5.0",
    },
    {
      "name": "Matéria 5",
      "desc": "Descrição da Matéria",
      "grade": "4.5",
    },
    {
      "name": "Matéria 6",
      "desc": "Descrição da Matéria",
      "grade": "4.5",
    },
    {
      "name": "Matéria 7",
      "desc": "Descrição da Matéria",
      "grade": "4.5",
    },
    {
      "name": "Matéria 8",
      "desc": "Descrição da Matéria",
      "grade": "4.5",
    },
    {
      "name": "Matéria 9",
      "desc": "Descrição da Matéria",
      "grade": "4.5",
    },
    {
      "name": "Matéria 10",
      "desc": "Descrição da Matéria",
      "grade": "4.5",
    },
  ];
  // @observable
  // Counter counter = Counter(value: 0);
  @observable
  CurrentCourses current_courses = CurrentCourses(courses: test_courses);

  // @action
  // void incrementCounter() {
  //   counter = Counter(value: counter.value + 1);
  // }
  @action
  void removeCourse(index) {
    current_courses.courses.removeAt(index);
    print(current_courses.courses);
  }
}
