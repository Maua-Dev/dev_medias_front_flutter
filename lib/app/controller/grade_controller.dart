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

  void _appendGradeSlots({
    required CourseModel course,
    required Map<String, dynamic> grades,
    required Map<String, dynamic> weights,
    required List<Map<String, dynamic>> provasTenho,
    required List<Map<String, dynamic>> trabalhosTenho,
    List<Map<String, dynamic>>? provasQuero,
    List<Map<String, dynamic>>? trabalhosQuero,
    required bool treatNullAsZero,
  }) {
    void consume(dynamic grade, {required bool isExam}) {
      final name = grade.name as String;
      final peso = normalizeGradeWeight(weights[name] ?? grade.weight);
      final raw = grades[name];
      final isEmpty = raw == null;

      if (isEmpty && !treatNullAsZero && provasQuero != null) {
        final bucket = isExam ? provasQuero : trabalhosQuero!;
        bucket.add({'peso': peso});
        return;
      }

      final bucket = isExam ? provasTenho : trabalhosTenho;
      bucket.add({
        'valor': isEmpty ? 0.0 : (raw as num).toDouble(),
        'peso': peso,
      });
    }

    for (final exam in course.exams ?? <dynamic>[]) {
      consume(exam, isExam: true);
    }
    for (final assignment in course.assignments ?? <dynamic>[]) {
      consume(assignment, isExam: false);
    }
  }

  Map<String, dynamic> _buildTargetGradePayload({
    required Map<String, dynamic> grades,
    required Map<String, dynamic> weights,
    required double targetGrade,
    required String courseCode,
  }) {
    final course = _course(courseCode);
    final provasTenho = <Map<String, dynamic>>[];
    final trabalhosTenho = <Map<String, dynamic>>[];
    final provasQuero = <Map<String, dynamic>>[];
    final trabalhosQuero = <Map<String, dynamic>>[];

    _appendGradeSlots(
      course: course,
      grades: grades,
      weights: weights,
      provasTenho: provasTenho,
      trabalhosTenho: trabalhosTenho,
      provasQuero: provasQuero,
      trabalhosQuero: trabalhosQuero,
      treatNullAsZero: false,
    );

    return {
      'provas_que_tenho': provasTenho,
      'trabalhos_que_tenho': trabalhosTenho,
      'provas_que_quero': provasQuero,
      'trabalhos_que_quero': trabalhosQuero,
      'media_desejada': targetGrade,
      'peso_prova': normalizeCourseComponentWeight(course.examWeight),
      'peso_trabalho': normalizeCourseComponentWeight(course.assignmentWeight),
    };
  }

  Map<String, dynamic> _buildFinalScorePayload({
    required Map<String, dynamic> grades,
    required Map<String, dynamic> weights,
    required String courseCode,
  }) {
    final course = _course(courseCode);
    final provasTenho = <Map<String, dynamic>>[];
    final trabalhosTenho = <Map<String, dynamic>>[];

    _appendGradeSlots(
      course: course,
      grades: grades,
      weights: weights,
      provasTenho: provasTenho,
      trabalhosTenho: trabalhosTenho,
      treatNullAsZero: true,
    );

    return {
      'provas_que_tenho': provasTenho,
      'trabalhos_que_tenho': trabalhosTenho,
      'peso_prova': normalizeCourseComponentWeight(course.examWeight),
      'peso_trabalho': normalizeCourseComponentWeight(course.assignmentWeight),
    };
  }

  Map<String, dynamic> _errorResult({
    required String message,
    int? statusCode,
  }) {
    return {
      'erro': message,
      if (statusCode != null) 'statusCode': statusCode,
    };
  }

  Future<Map<String, dynamic>> _postJson(
    String url,
    Map<String, dynamic> body,
  ) async {
    try {
      final response = await dio.post(url, data: body);
      final statusCode = response.statusCode;
      if (statusCode == 200) {
        if (response.data is Map) {
          return Map<String, dynamic>.from(response.data as Map);
        }
        final message = errorMessageFromApiBody(response.data);
        return _errorResult(
          message: message ?? 'Resposta inválida da API',
          statusCode: statusCode,
        );
      }
      return _errorResult(
        message: errorMessageFromApiBody(response.data) ??
            'Erro na solicitação POST ($statusCode)',
        statusCode: statusCode,
      );
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final message = errorMessageFromApiBody(e.response?.data) ??
          e.message ??
          'Erro de rede';
      return _errorResult(message: message, statusCode: statusCode);
    } catch (e) {
      return _errorResult(message: 'Erro de rede: $e');
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
