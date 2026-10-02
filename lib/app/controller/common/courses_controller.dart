import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/service/course_service.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'courses_controller.g.dart';

class CoursesController = CoursesControllerBase with _$CoursesController;

abstract class CoursesControllerBase with Store {
  CoursesControllerBase();

  final dio = Dio();

  final service = courseService;

  @observable
  ObservableMap<String, dynamic>? allCourses;

  @computed
  Map<String, dynamic> get getAllCourses {
    final result = <String, dynamic>{};
    allCourses!.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }

  @computed
  int get customCoursesCount {
    final catalog = allCourses;
    if (catalog == null || catalog.isEmpty) return 0;
    return catalog.values
        .whereType<CourseModel>()
        .where((course) => course.isCustom)
        .length;
  }

  @computed
  bool get atCustomLimit =>
      customCoursesCount >= kMaxCustomSubjectsPerDevice;

  @action
  void setAllCourses(Map<String, dynamic> courses) {
    allCourses = ObservableMap<String, dynamic>.of(courses);
  }

  @observable
  bool loadedCourses = false;

  @computed
  bool get getLoadedCourses => loadedCourses;

  @action
  void setLoadedCourses(bool status) {
    loadedCourses = status;
  }

  // delete all current courses
  @action
  void deleteAllCurrentCourses() {
    userController.deleteAllCurrentCourses();
  }

  // Requisição de matérias
  @action
  Future<Map<String, dynamic>> fetchCourses() async {
    setLoadedCourses(false);
    try {
      final response = await service.getCourses();
      setLoadedCourses(true);
      return response;
    } catch (e) {
      setLoadedCourses(allCourses != null && allCourses!.isNotEmpty);
      rethrow;
    }
  }

  /// GET de todas as disciplinas + atualização do catálogo e lista da home.
  @action
  Future<bool> refreshAllSubjects() async {
    try {
      final courses = await fetchCourses();
      setAllCourses(courses);
      await userController.pruneCurrentCoursesWithCatalog();
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Remove da home. Catálogo oficial: só Hive. Custom: DELETE na API + refetch.
  @action
  Future<void> removeCourseFromHome(CourseModel course) async {
    if (course.isCustom) {
      await service.deleteCustomCourse(course.code);
      await userController.removeCurrentCourse(course.code);
      await refreshAllSubjects();
      return;
    }
    await userController.removeCurrentCourse(course.code);
  }
}

CoursesController coursesController = CoursesController();
