import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:mobx/mobx.dart';
part 'add_page_controller.g.dart';

class AddPageController = AddPageControllerBase with _$AddPageController;

abstract class AddPageControllerBase with Store {
  AddPageControllerBase();

  static List<Course> testAvailableCourses = [
    Course(
        id: "2", name: "Matéria 2", desc: "Descrição da Matéria", grade: "2.5"),
    Course(
        id: "3", name: "Matéria 3", desc: "Descrição da Matéria", grade: "9.5"),
    Course(
        id: "4", name: "Matéria 4", desc: "Descrição da Matéria", grade: "6.0"),
    Course(
        id: "5", name: "Matéria 5", desc: "Descrição da Matéria", grade: "4.5"),
    Course(
        id: "6", name: "Matéria 6", desc: "Descrição da Matéria", grade: "5.0"),
  ];

  @observable
  ObservableList<Course> availableCourses =
      ObservableList<Course>.of(testAvailableCourses);
  // AvailableCourses availableCourses = AvailableCourses(courses: testCourses);

  @action
  void addCurrentCourse(Course course) {
    homeController.currentCourses.add(course);
    removeAvailableCourse(course);
  }

  @action
  void addAvailableCourse(Course course) {
    availableCourses.add(course);
  }

  @action
  void removeAvailableCourse(Course course) {
    availableCourses.remove(course);
  }
}

AddPageController addController = AddPageController();
