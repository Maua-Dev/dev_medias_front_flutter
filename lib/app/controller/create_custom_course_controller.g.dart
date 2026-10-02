// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_custom_course_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateCustomCourseController
    on CreateCustomCourseControllerBase, Store {
  late final _$submittingAtom = Atom(
      name: 'CreateCustomCourseControllerBase.submitting', context: context);

  @override
  bool get submitting {
    _$submittingAtom.reportRead();
    return super.submitting;
  }

  @override
  set submitting(bool value) {
    _$submittingAtom.reportWrite(value, super.submitting, () {
      super.submitting = value;
    });
  }

  late final _$codeErrorAtom = Atom(
      name: 'CreateCustomCourseControllerBase.codeError', context: context);

  @override
  String? get codeError {
    _$codeErrorAtom.reportRead();
    return super.codeError;
  }

  @override
  set codeError(String? value) {
    _$codeErrorAtom.reportWrite(value, super.codeError, () {
      super.codeError = value;
    });
  }

  late final _$formErrorAtom = Atom(
      name: 'CreateCustomCourseControllerBase.formError', context: context);

  @override
  String? get formError {
    _$formErrorAtom.reportRead();
    return super.formError;
  }

  @override
  set formError(String? value) {
    _$formErrorAtom.reportWrite(value, super.formError, () {
      super.formError = value;
    });
  }

  late final _$submitAsyncAction =
      AsyncAction('CreateCustomCourseControllerBase.submit', context: context);

  @override
  Future<CourseModel?> submit(
      {required String code,
      required String name,
      String period = '',
      double examWeight = 0.5,
      double assignmentWeight = 0.5,
      List<Map<String, dynamic>> exams = const [],
      List<Map<String, dynamic>> assignments = const []}) {
    return _$submitAsyncAction.run(() => super.submit(
        code: code,
        name: name,
        period: period,
        examWeight: examWeight,
        assignmentWeight: assignmentWeight,
        exams: exams,
        assignments: assignments));
  }

  late final _$CreateCustomCourseControllerBaseActionController =
      ActionController(
          name: 'CreateCustomCourseControllerBase', context: context);

  @override
  void clearErrors() {
    final _$actionInfo = _$CreateCustomCourseControllerBaseActionController
        .startAction(name: 'CreateCustomCourseControllerBase.clearErrors');
    try {
      return super.clearErrors();
    } finally {
      _$CreateCustomCourseControllerBaseActionController
          .endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
submitting: ${submitting},
codeError: ${codeError},
formError: ${formError}
    ''';
  }
}
