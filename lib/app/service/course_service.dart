import 'dart:async';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CourseService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getCourses() async {
    try {
      final response = await dio.get(dotenv.env['API_SUBJECTS']!);
      if (response.statusCode == 200) {
        final subjects = _parseSubjectsPayload(response.data);
        final Map<String, CourseModel> aux = {};

        for (final raw in subjects) {
          final course = _toCourseModel(raw);
          aux[course.code] = course;
        }

        return aux;
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }

  /// API nova: lista JSON; CDN antigo: mapa indexado por código.
  List<Map<String, dynamic>> _parseSubjectsPayload(dynamic data) {
    if (data is List) {
      return data
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    if (data is Map) {
      return data.entries.map((entry) {
        final subject = Map<String, dynamic>.from(entry.value as Map);
        subject.putIfAbsent('code', () => entry.key.toString());
        return subject;
      }).toList();
    }
    throw Exception('Formato de disciplinas não reconhecido');
  }

  Map<String, dynamic> _normalizeSubjectFields(Map<String, dynamic> raw) {
    return {
      'code': raw['code'],
      'name': raw['name'],
      'period': raw['period'],
      'examWeight': raw['examWeight'] ?? raw['exam_weight'],
      'assignmentWeight': raw['assignmentWeight'] ?? raw['assignment_weight'],
      'exams': raw['exams'] ?? [],
      'assignments': raw['assignments'] ?? [],
      'courses': raw['courses'],
    };
  }

  CourseModel _toCourseModel(Map<String, dynamic> raw) {
    final course = _normalizeSubjectFields(raw);

    final exams = <GradeModel>[];
    for (final exam in course['exams'] as List) {
      exams.add(GradeModel.fromJson(Map<String, dynamic>.from(exam as Map)));
    }
    course['exams'] = exams;

    final assignments = <GradeModel>[];
    for (final assignment in course['assignments'] as List) {
      assignments.add(
          GradeModel.fromJson(Map<String, dynamic>.from(assignment as Map)));
    }
    course['assignments'] = assignments;

    return CourseModel.fromJson(course);
  }
}

CourseService courseService = CourseService();
