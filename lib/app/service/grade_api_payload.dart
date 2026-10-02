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

/// Família do critério (ex.: C4 de C4/2015). Null se exams_code ausente.
String? examsCodeFamily(String? examsCode) {
  if (examsCode == null || examsCode.isEmpty) return null;
  final match = RegExp(r'^([A-Za-z]\d+)').firstMatch(examsCode.trim());
  return match?.group(1)?.toUpperCase();
}

bool hasExamsCode(CourseModel course) {
  final code = course.examsCode;
  return code != null && code.isNotEmpty;
}

bool hasStudyPlanPdf(CourseModel course) {
  final url = course.studyPlanDownloadPdfUrl;
  return url != null && url.isNotEmpty;
}

/// Referência UI: família do critério → estrutura esperada de provas/trabalhos.
const List<({String family, String structure})> examsCodeReferenceRows = [
  (family: 'A*', structure: '0 provas + trabalhos'),
  (family: 'B1', structure: '2 provas'),
  (family: 'B2', structure: '4 provas'),
  (family: 'B3', structure: '1 prova'),
  (family: 'outros B*', structure: '2 provas'),
  (family: 'C1', structure: 'trabalhos + 2 provas'),
  (family: 'C2', structure: 'trabalhos + 4 provas'),
  (family: 'C3', structure: 'trabalhos + 1 prova'),
  (family: 'outros C* (inclui C4)', structure: 'trabalhos + 2 provas'),
  (family: 'E*', structure: 'tratamento específico no plano'),
];

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
