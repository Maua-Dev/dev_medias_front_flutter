import 'dart:async';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CourseService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getCourses() async {
    try {
      final response = await dio
          .get(dotenv.env['COURSES_URL']!);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        Map<String, CourseModel> aux = {};

        data.forEach((code, course) {
          // converte as provas no formato GradeModel
          final prevExams = course["exams"];
          final newExamList = [];
          for (Map<String, dynamic> exam in prevExams) {
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
        return courses;
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }

}

CourseService courseService = CourseService();
