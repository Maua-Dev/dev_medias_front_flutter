import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:mobx/mobx.dart';
part 'add_page_controller.g.dart';

class AddPageController = AddPageControllerBase with _$AddPageController;

abstract class AddPageControllerBase with Store {
  AddPageControllerBase();

  @observable
  bool coursesLoaded = false;

  @observable
  ObservableMap<String, dynamic>? availableCourses;

  @observable
  String userSearch = '';

  @action
  Future<void> loadCourses() async {
    setCoursesLoaded(false);
    final result = await coursesController.getCourses();
    result.removeWhere(
        (key, value) => userController.currentCourses.contains(value.code));
    availableCourses = ObservableMap<String, dynamic>.of(result);
    setCoursesLoaded(true);
  }

  @action
  void setCoursesLoaded(bool status) {
    coursesLoaded = status;
  }

  @action
  void searchAvailableCourses() {
    Map<String, dynamic> aux = {};
    coursesController.allCourses!.forEach((key, value) {
      var notCurrent =
          userController.currentCourses.where((code) => code == value.code);
      if (notCurrent.isEmpty) {
        if (value.name.toLowerCase().contains(userSearch.toLowerCase()) |
            value.code.toLowerCase().contains(userSearch.toLowerCase())) {
          aux[key] = value;
        }
      }
    });
    availableCourses = ObservableMap<String, dynamic>.of(aux);
  }

  @action
  void setSearchTerm(String value) {
    userSearch = value;
  }
}

AddPageController addController = AddPageController();
