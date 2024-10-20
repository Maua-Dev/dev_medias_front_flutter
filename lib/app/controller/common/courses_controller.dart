import 'dart:async';
import 'package:dev_medias_front_flutter/app/service/course_service.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'courses_controller.g.dart';

class CoursesController = CoursesControllerBase with _$CoursesController;

abstract class CoursesControllerBase with Store {
  CoursesControllerBase();

  final dio = Dio();

  final service = CourseService();

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

  // Requisição de matérias
  @action
  Future<Map<String, dynamic>> fetchCourses() async {
    setLoadedCourses(false);
    try {
      final response = await service.getCourses();
      setLoadedCourses(true);
      return response;
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}

CoursesController coursesController = CoursesController();
