import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dev_medias_front_flutter/app/service/grade_api_payload.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('normalizeCourseComponentWeight aceita fração e percentual', () {
    expect(normalizeCourseComponentWeight(0.6), 0.6);
    expect(normalizeCourseComponentWeight(60), 0.6);
  });

  test('isExamGrade usa nomes canônicos P# / T# da matéria', () {
    final course = CourseModel(
      code: 'CIC401',
      exams: [GradeModel(name: 'P1', weight: 0.4)],
      assignments: [GradeModel(name: 'T1', weight: 0.5)],
      examsCode: 'C2/2007',
      studyPlanDownloadPdfUrl:
          'https://d30dkpphecvqs6.cloudfront.net/example.pdf',
    );

    expect(isExamGrade('P1', course), isTrue);
    expect(isExamGrade('T1', course), isFalse);
    expect(isExamGrade('Primeira Prova Bimestral', course), isFalse);
  });

  test('examsCodeFamily extrai prefixo do critério', () {
    expect(examsCodeFamily('C4/2015'), 'C4');
    expect(examsCodeFamily('B1'), 'B1');
    expect(examsCodeFamily(null), isNull);
    expect(examsCodeFamily(''), isNull);
  });

  test('hasStudyPlanPdf só é true com URL truthy', () {
    expect(
      hasStudyPlanPdf(CourseModel(
        studyPlanDownloadPdfUrl:
            'https://d30dkpphecvqs6.cloudfront.net/example.pdf',
      )),
      isTrue,
    );
    expect(hasStudyPlanPdf(CourseModel()), isFalse);
    expect(
      hasStudyPlanPdf(CourseModel(studyPlanDownloadPdfUrl: '')),
      isFalse,
    );
  });

  test('hasExamsCode só é true com código truthy', () {
    expect(hasExamsCode(CourseModel(examsCode: 'C3/2015')), isTrue);
    expect(hasExamsCode(CourseModel()), isFalse);
    expect(hasExamsCode(CourseModel(examsCode: '')), isFalse);
  });
}
