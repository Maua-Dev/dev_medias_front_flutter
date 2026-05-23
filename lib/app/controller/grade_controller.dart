import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/service/grade_api_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobx/mobx.dart';
part 'grade_controller.g.dart';

class GradeController = GradeControllerBase with _$GradeController;

abstract class GradeControllerBase with Store {
  GradeControllerBase();

  final dio = Dio();

  CourseModel _course(String courseCode) {
    final course = coursesController.allCourses?[courseCode];
    if (course == null) {
      throw Exception('Matéria $courseCode não encontrada');
    }
    return course as CourseModel;
  }

  @action
  Future<dynamic> getGrades(String code) async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    final grades = box.get('grades', defaultValue: <String, dynamic>{});
    final subjectGrades = grades?[code];
    return subjectGrades;
  }

  @action
  Future<void> insertGrades(String code, Map<String, dynamic> grades) async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    final oldGrades = box.get('grades', defaultValue: <String, Map>{});
    final newGrades = oldGrades;
    newGrades[code] = grades;
    box.put('grades', newGrades);
  }

  Map<String, dynamic> _buildTargetGradePayload({
    required Map<String, dynamic> grades,
    required Map<String, dynamic> weights,
    required double targetGrade,
    required String courseCode,
  }) {
    final course = _course(courseCode);
    final gradeMap = <String, dynamic>{
      'provas_que_tenho': <Map<String, dynamic>>[],
      'trabalhos_que_tenho': <Map<String, dynamic>>[],
      'provas_que_quero': <Map<String, dynamic>>[],
      'trabalhos_que_quero': <Map<String, dynamic>>[],
      'media_desejada': targetGrade,
      'peso_prova': normalizeCourseComponentWeight(course.examWeight),
      'peso_trabalho': normalizeCourseComponentWeight(course.assignmentWeight),
    };

    for (final item in grades.entries) {
      final peso = normalizeGradeWeight(weights[item.key]);
      final isExam = isExamGrade(item.key, course);
      if (item.value == null) {
        final bucket =
            isExam ? 'provas_que_quero' : 'trabalhos_que_quero';
        (gradeMap[bucket] as List).add({'peso': peso});
      } else {
        final bucket =
            isExam ? 'provas_que_tenho' : 'trabalhos_que_tenho';
        (gradeMap[bucket] as List).add({
          'valor': (item.value as num).toDouble(),
          'peso': peso,
        });
      }
    }

    return gradeMap;
  }

  Map<String, dynamic> _buildFinalScorePayload({
    required Map<String, dynamic> grades,
    required Map<String, dynamic> weights,
    required String courseCode,
  }) {
    final course = _course(courseCode);
    final gradeMap = <String, dynamic>{
      'provas_que_tenho': <Map<String, dynamic>>[],
      'trabalhos_que_tenho': <Map<String, dynamic>>[],
      'peso_prova': normalizeCourseComponentWeight(course.examWeight),
      'peso_trabalho': normalizeCourseComponentWeight(course.assignmentWeight),
    };

    for (final item in grades.entries) {
      final peso = normalizeGradeWeight(weights[item.key]);
      final bucket = isExamGrade(item.key, course)
          ? 'provas_que_tenho'
          : 'trabalhos_que_tenho';
      (gradeMap[bucket] as List).add({
        'valor': item.value == null ? 0.0 : (item.value as num).toDouble(),
        'peso': peso,
      });
    }

    return gradeMap;
  }

  Future<Map<String, dynamic>> _postJson(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        if (response.data is Map) {
          return Map<String, dynamic>.from(response.data as Map);
        }
        final message = errorMessageFromApiBody(response.data);
        return {'erro': message ?? 'Resposta inválida da API'};
      }
      return {'erro': 'Erro na solicitação POST (${response.statusCode})'};
    } on DioException catch (e) {
      final message = errorMessageFromApiBody(e.response?.data) ??
          e.message ??
          'Erro de rede';
      return {'erro': message};
    } catch (e) {
      return {'erro': 'Erro de rede: $e'};
    }
  }

  @action
  Future<Map<String, dynamic>> getTargetGrades(
    Map<String, dynamic> grades,
    Map<String, dynamic> weights,
    double targetGrade,
    String courseCode,
  ) async {
    final gradeMap = _buildTargetGradePayload(
      grades: grades,
      weights: weights,
      targetGrade: targetGrade,
      courseCode: courseCode,
    );
    return _postJson(dotenv.env['API_GENETIC_ALGORITHM']!, gradeMap);
  }

  @action
  Future<Map<String, dynamic>> getFinalScore(
    Map<String, dynamic> grades,
    Map<String, dynamic> weights,
    String courseCode,
  ) async {
    final gradeMap = _buildFinalScorePayload(
      grades: grades,
      weights: weights,
      courseCode: courseCode,
    );
    return _postJson(dotenv.env['API_FINAL_SCORE_URL']!, gradeMap);
  }
}

GradeController gradeController = GradeController();
