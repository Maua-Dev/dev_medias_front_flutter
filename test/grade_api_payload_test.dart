import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dev_medias_front_flutter/app/service/grade_api_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizeCourseComponentWeight aceita fração e percentual', () {
    expect(normalizeCourseComponentWeight(0.6), 0.6);
    expect(normalizeCourseComponentWeight(60), 0.6);
  });

  test('normalizeGradeWeight preserva casas (ex.: 0.25)', () {
    expect(normalizeGradeWeight(0.25), 0.25);
    expect(normalizeGradeWeight(0.2), 0.2);
  });

  test('isExamGrade usa nomes da matéria, não a primeira letra', () {
    final course = CourseModel(
      code: 'CIC401',
      exams: [GradeModel(name: 'Primeira Prova Bimestral', weight: 0.4)],
      assignments: [GradeModel(name: 'Trabalho 1', weight: 0.5)],
    );

    expect(isExamGrade('Primeira Prova Bimestral', course), isTrue);
    expect(isExamGrade('Trabalho 1', course), isFalse);
    expect(isExamGrade('Prova P1', course), isFalse);
  });

  test('mapGeneticGapsToGradeNames mapeia só lacunas na ordem', () {
    final mapped = mapGeneticGapsToGradeNames(
      emptyExamNames: ['P2', 'P3'],
      emptyAssignmentNames: ['T1'],
      provasMeta: [
        {'valor': 6.5, 'peso': 0.25},
        {'valor': 7.0, 'peso': 0.25},
      ],
      trabalhosMeta: [
        {'valor': 0.0, 'peso': 0.5},
      ],
    );

    expect(mapped, {
      'P2': 6.5,
      'P3': 7.0,
      'T1': 0.0,
    });
  });

  test('mapGeneticGapsToGradeNames falha se tamanho divergir', () {
    final mapped = mapGeneticGapsToGradeNames(
      emptyExamNames: ['P2', 'P3'],
      emptyAssignmentNames: [],
      provasMeta: [
        {'valor': 6.5, 'peso': 0.25},
      ],
      trabalhosMeta: [],
    );

    expect(mapped, isNull);
  });

  test('targetCalcUserMessage trata 404 como meta inatingível', () {
    expect(
      targetCalcUserMessage(statusCode: 404, apiMessage: 'qualquer'),
      impossibleTargetMessage,
    );
    expect(
      targetCalcUserMessage(statusCode: 400, apiMessage: 'peso inválido'),
      'peso inválido',
    );
  });
}
