import 'package:dev_medias_front_flutter/app/controller/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/available_courses.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:mobx/mobx.dart';
part 'add_page_controller.g.dart';

class AddPageController = AddPageControllerBase with _$AddPageController;

abstract class AddPageControllerBase with Store {
  AddPageControllerBase();

  static List<CourseModel> testAvailableCourses = [
    // CourseModel(
    //     id: "2", name: "Matéria 2", desc: "Descrição da Matéria", grade: "2.5"),
    // CourseModel(
    //     id: "3", name: "Matéria 3", desc: "Descrição da Matéria", grade: "9.5"),
    // CourseModel(
    //     id: "4", name: "Matéria 4", desc: "Descrição da Matéria", grade: "6.0"),
    // CourseModel(
    //     id: "5", name: "Matéria 5", desc: "Descrição da Matéria", grade: "4.5"),
    // CourseModel(
    //     id: "6", name: "Matéria 6", desc: "Descrição da Matéria", grade: "5.0"),
  ];

  @observable
  bool coursesLoaded = false;

  @observable
  ObservableMap<String, dynamic>? availableCourses;

  @observable
  String userSearch = '';
  // AvailableCourses availableCourses = AvailableCourses(courses: testCourses);

  @action
  Future<void> loadCourses() async {
    final result = await coursesController.getCourses();
    availableCourses = ObservableMap<String, dynamic>.of(result);
  }

  @action
  void setCoursesLoaded(bool status) {
    coursesLoaded = status;
  }

  @action
  void searchAvailableCourses() {
    Map<String, dynamic> aux = {};
    coursesController.allCourses!.forEach((key, value) {
      if (value.name.toLowerCase().contains(userSearch.toLowerCase()) |
          value.code.toLowerCase().contains(userSearch.toLowerCase())) {
        aux[key] = value;
      }
    });
    availableCourses = ObservableMap<String, dynamic>.of(aux);
  }

  @action
  void addCurrentCourse(CourseModel course) {
    homeController.currentCourses.add(course);
    // removeAvailableCourse(course);
  }

  @action
  void setSearchTerm(String value) {
    userSearch = value;
  }

  // @action
  // void addAvailableCourse(CourseModel course) {
  //   availableCourses.add(course);
  // }

  // @action
  // void removeAvailableCourse(CourseModel course) {
  //   availableCourses.remove(course);
  // }
}

AddPageController addController = AddPageController();
