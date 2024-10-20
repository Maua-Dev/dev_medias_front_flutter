// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grade_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GradeController on GradeControllerBase, Store {
  late final _$getGradesAsyncAction =
      AsyncAction('GradeControllerBase.getGrades', context: context);

  @override
  Future<dynamic> getGrades(String code) {
    return _$getGradesAsyncAction.run(() => super.getGrades(code));
  }

  late final _$insertGradesAsyncAction =
      AsyncAction('GradeControllerBase.insertGrades', context: context);

  @override
  Future<void> insertGrades(String code, Map<String, dynamic> grades) {
    return _$insertGradesAsyncAction
        .run(() => super.insertGrades(code, grades));
  }

  late final _$getTargetGradesAsyncAction =
      AsyncAction('GradeControllerBase.getTargetGrades', context: context);

  @override
  Future<Map<String, dynamic>> getTargetGrades(Map<String, dynamic> grades,
      Map<String, dynamic> weights, double targetGrade, String courseCode) {
    return _$getTargetGradesAsyncAction.run(
        () => super.getTargetGrades(grades, weights, targetGrade, courseCode));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
