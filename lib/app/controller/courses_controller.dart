import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'courses_controller.g.dart';

class CoursesController = CoursesControllerBase with _$CoursesController;

abstract class CoursesControllerBase with Store {
  CoursesControllerBase();

  final dio = Dio();

  @observable
  ObservableMap<String, dynamic>? allCourses;

  @observable
  ObservableMap<String, dynamic>? allGrads;

  @observable
  bool loadedCourses = false;

  @action
  void setLoadedCourses(bool status) {
    loadedCourses = status;
  }

  @action
  getAllGrads() {
    return allGrads;
  }

  @action
  Future<Map<String, dynamic>> getCourses() async {
    try {
      final response = await dio
          .get("https://d2aa4b9d9pswiy.cloudfront.net/allSubjects.json");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        Map<String, CourseModel> aux = {};

        data.forEach((code, course) {
          // converte as provas no formato GradeModel
          final prevExams = course["exams"];
          final newExamList = [];
          for (Map<String, dynamic> exam in prevExams) {
            print(exam);
            newExamList.add(GradeModel.fromJson(exam));
          }
          course["exams"] = newExamList;
          // converte os trabalhos no formato GradeModel
          final prevAssignments = course["assignments"];
          final newAssignmentList = [];
          for (Map<String, dynamic> assignment in prevAssignments) {
            newAssignmentList.add(GradeModel.fromJson(assignment));
          }
          course["assignments"] = newAssignmentList;
          course = CourseModel.fromJson(course);
          aux[code] = course;
        });

        Map<String, CourseModel> courses = aux;
        addController.setCoursesLoaded(true);
        setLoadedCourses(true);
        allCourses = ObservableMap<String, dynamic>.of(courses);
        loadedCourses = true;
        return courses;
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }

  @action
  Future<Map<String, dynamic>> getGrads() async {
    try {
      final response =
          await dio.get("https://d2aa4b9d9pswiy.cloudfront.net/courses.json");
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        allGrads = ObservableMap<String, dynamic>.of(data);
        return data;
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }

  @action
  List<String> getDropdownInputStrings() {
    List<String> aux = [];
    allGrads!.forEach((key, value) {
      aux.add('$key');
    });
    return aux;
  }
}

CoursesController coursesController = CoursesController();
