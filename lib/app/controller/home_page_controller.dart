import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();

  static var testCurrentCourses = [
    Course(id: "1", name: "materia 1", desc: "desc materia", grade: "1.0"),
    Course(id: "7", name: "materia 7", desc: "desc materia", grade: "2.0"),
    Course(id: "8", name: "materia 8", desc: "desc materia", grade: "3.0"),
  ];

  // @observable
  // Counter counter = Counter(value: 0);
  @observable
  ObservableList<Course> currentCourses =
      ObservableList<Course>.of(testCurrentCourses);

  // @action
  // void incrementCounter() {
  //   counter = Counter(value: counter.value + 1);
  // }

  @action
  void removeCurrentCourse(Course course) {
    currentCourses.remove(course);
    addController.addAvailableCourse(course);
  }

  @action
  void loadUserCourses() {
    
  }
}

HomePageController homeController = HomePageController();
