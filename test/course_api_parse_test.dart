import 'package:dev_medias_front_flutter/app/service/course_service.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('courseModelFromApi parseia resposta snake_case do create-custom', () {
    final course = courseModelFromApi({
      'course': 'CUSTOM',
      'name': 'Minha matéria',
      'code': 'MIN001',
      'period': '2026.1',
      'exam_weight': 0.7,
      'assignment_weight': 0.3,
      'exams': [
        {'name': 'P1', 'weight': 1.0},
      ],
      'assignments': [],
      'courses': {},
      'study_plan_download_pdf_url': null,
      'exams_code': null,
      'device_id': '550e8400-e29b-41d4-a716-446655440000',
      'is_custom': true,
      'created_at': '2026-10-02T15:00:00Z',
      'updated_at': '2026-10-02T15:00:00Z',
    });

    expect(course.code, 'MIN001');
    expect(course.name, 'Minha matéria');
    expect(course.examWeight, 0.7);
    expect(course.assignmentWeight, 0.3);
    expect(course.isCustom, isTrue);
    expect(course.deviceId, '550e8400-e29b-41d4-a716-446655440000');
    expect(course.exams, isNotEmpty);
    expect(course.exams!.first.name, 'P1');
  });

  test('courseModelFromApi aceita assignment_weight 0.0', () {
    final course = courseModelFromApi({
      'code': 'ONLYEX',
      'name': 'Só provas',
      'period': '',
      'exam_weight': 1.0,
      'assignment_weight': 0.0,
      'exams': [
        {'name': 'P1', 'weight': 1.0},
      ],
      'assignments': [],
      'is_custom': true,
    });

    expect(course.assignmentWeight, 0.0);
    expect(course.isCustom, isTrue);
  });
}
