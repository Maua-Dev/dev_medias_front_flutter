import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/current_courses.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();

  static var testCourses = [
    Course(id: "1", name: "materia 1", desc: "desc materia", grade: "1.0")
  ];

  // @observable
  // Counter counter = Counter(value: 0);
  @observable
  ObservableList<Course> currentCourses = ObservableList<Course>.of(testCourses);
  // CurrentCourses currentCourses = CurrentCourses(courses: testCourses);

  // @action
  // void incrementCounter() {
  //   counter = Counter(value: counter.value + 1);
  // }

  @action
  void removeCurrentCourse(id) {
    currentCourses.removeWhere((course) => course.id == id);
  }
}

HomePageController homeController = HomePageController();
