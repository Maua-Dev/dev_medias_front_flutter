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

/// Status do algoritmo genético (contrato atual).
const String geneticStatusExact = 'exact';
const String geneticStatusClose = 'close';
const String geneticStatusAlreadyAchieved = 'already_achieved';

const String impossibleTargetMessage =
    'Meta inatingível com as notas atuais. Tente baixar a meta ou revisar as notas e pesos lançados.';

const String alreadyAchievedMessage =
    'Você já atinge essa média com as notas lançadas. As lacunas foram preenchidas com 0.';

const String closeSolutionMessage =
    'Encontramos uma combinação próxima da meta (pode diferir um pouco).';

/// Mapeia só as lacunas da resposta (`notas.provas` / `notas.trabalhos`)
/// para os nomes das avaliações vazias, na mesma ordem do request.
/// Retorna null se o tamanho não bater.
Map<String, double>? mapGeneticGapsToGradeNames({
  required List<String> emptyExamNames,
  required List<String> emptyAssignmentNames,
  required List<Map<String, dynamic>> provasMeta,
  required List<Map<String, dynamic>> trabalhosMeta,
}) {
  if (emptyExamNames.length != provasMeta.length ||
      emptyAssignmentNames.length != trabalhosMeta.length) {
    return null;
  }

  final mapped = <String, double>{};
  for (var i = 0; i < emptyExamNames.length; i++) {
    final valor = provasMeta[i]['valor'];
    if (valor is! num) return null;
    mapped[emptyExamNames[i]] = valor.toDouble();
  }
  for (var i = 0; i < emptyAssignmentNames.length; i++) {
    final valor = trabalhosMeta[i]['valor'];
    if (valor is! num) return null;
    mapped[emptyAssignmentNames[i]] = valor.toDouble();
  }
  return mapped;
}

String targetCalcUserMessage({
  required int? statusCode,
  String? apiMessage,
}) {
  if (statusCode == 404) return impossibleTargetMessage;
  if (apiMessage != null && apiMessage.trim().isNotEmpty) {
    return apiMessage;
  }
  return 'Erro ao calcular as notas. Tente novamente.';
}
