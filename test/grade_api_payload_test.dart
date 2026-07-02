import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dev_medias_front_flutter/app/service/grade_api_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizeCourseComponentWeight aceita fração e percentual', () {
    expect(normalizeCourseComponentWeight(0.6), 0.6);
    expect(normalizeCourseComponentWeight(60), 0.6);
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
}
