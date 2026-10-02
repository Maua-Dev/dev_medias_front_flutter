import 'package:dev_medias_front_flutter/app/model/course.dart';

/// Converte peso da matéria (0.6 na API nova ou 60 no JSON antigo) para fração 0–1.
double normalizeCourseComponentWeight(dynamic weight) {
  final value = (weight as num).toDouble();
  return value > 1 ? value / 100 : value;
}

double normalizeGradeWeight(dynamic weight) => (weight as num).toDouble();

Set<String> examNamesFor(CourseModel course) {
  return (course.exams ?? [])
      .map((exam) => exam.name as String)
      .toSet();
}

Set<String> assignmentNamesFor(CourseModel course) {
  return (course.assignments ?? [])
      .map((assignment) => assignment.name as String)
      .toSet();
}

bool isExamGrade(String gradeName, CourseModel course) {
  return examNamesFor(course).contains(gradeName);
}

String? errorMessageFromApiBody(dynamic body) {
  if (body is Map && body['erro'] != null) {
    return body['erro'].toString();
  }
  if (body is Map && body['message'] != null) {
    return body['message'].toString();
  }
  if (body is String) {
    return body;
  }
  return null;
}
