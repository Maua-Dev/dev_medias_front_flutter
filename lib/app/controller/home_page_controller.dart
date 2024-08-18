import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:mobx/mobx.dart';
part 'home_page_controller.g.dart';

class HomePageController = HomePageControllerBase with _$HomePageController;

abstract class HomePageControllerBase with Store {
  HomePageControllerBase();

  static var testCurrentCourses = [
    CourseModel(),
    CourseModel(),
    CourseModel(),
  ];

  @observable
  ObservableList<CourseModel?> currentCourses = ObservableList<CourseModel?>.of([]);
  // ObservableList<CourseModel> currentCourses =
  //     ObservableList<CourseModel>.of(testCurrentCourses);

  @action
  void removeCurrentCourse(CourseModel course) {
    currentCourses.remove(course);
    // addController.addAvailableCourse(course);
  }

  // @action
  // Future<void> loadCourses() async {
  //   final result = await coursesController.getCourses();
  //   // currentCourses = ObservableList<CourseModel?>.of(result);
  // }

  // @action
  // void loadAllCourses() {
  //   readJsonFile("F:/dev/flutter/dev_medias/lib/app/allSubjects.json");
  // }

  @action
  void loadUserCourses() {}
}

HomePageController homeController = HomePageController();
