// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditPageController on EditPageControllerBase, Store {
  late final _$targetGradeAtom =
      Atom(name: 'EditPageControllerBase.targetGrade', context: context);

  @override
  double get targetGrade {
    _$targetGradeAtom.reportRead();
    return super.targetGrade;
  }

  @override
  set targetGrade(double value) {
    _$targetGradeAtom.reportWrite(value, super.targetGrade, () {
      super.targetGrade = value;
    });
  }

  late final _$courseCodeAtom =
      Atom(name: 'EditPageControllerBase.courseCode', context: context);

  @override
  String get courseCode {
    _$courseCodeAtom.reportRead();
    return super.courseCode;
  }

  @override
  set courseCode(String value) {
    _$courseCodeAtom.reportWrite(value, super.courseCode, () {
      super.courseCode = value;
    });
  }

  late final _$gradesAtom =
      Atom(name: 'EditPageControllerBase.grades', context: context);

  @override
  ObservableMap<String, double?> get grades {
    _$gradesAtom.reportRead();
    return super.grades;
  }

  @override
  set grades(ObservableMap<String, double?> value) {
    _$gradesAtom.reportWrite(value, super.grades, () {
      super.grades = value;
    });
  }

  late final _$gradeControllersAtom =
      Atom(name: 'EditPageControllerBase.gradeControllers', context: context);

  @override
  ObservableMap<String, TextEditingController> get gradeControllers {
    _$gradeControllersAtom.reportRead();
    return super.gradeControllers;
  }

  @override
  set gradeControllers(ObservableMap<String, TextEditingController> value) {
    _$gradeControllersAtom.reportWrite(value, super.gradeControllers, () {
      super.gradeControllers = value;
    });
  }

  late final _$calcTargetGradeAsyncAction =
      AsyncAction('EditPageControllerBase.calcTargetGrade', context: context);

  @override
  Future<Map<String, dynamic>> calcTargetGrade(Map<String, dynamic> grades,
      Map<String, dynamic> weights, double targetGrade) {
    return _$calcTargetGradeAsyncAction
        .run(() => super.calcTargetGrade(grades, weights, targetGrade));
  }

  late final _$EditPageControllerBaseActionController =
      ActionController(name: 'EditPageControllerBase', context: context);

  @override
  String getCourseCode() {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.getCourseCode');
    try {
      return super.getCourseCode();
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCourseCode(String code) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.setCourseCode');
    try {
      return super.setCourseCode(code);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  double getTargetGrade() {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.getTargetGrade');
    try {
      return super.getTargetGrade();
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTargetGrade(double grade) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.setTargetGrade');
    try {
      return super.setTargetGrade(grade);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buildGrades(List<dynamic>? grades) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.buildGrades');
    try {
      return super.buildGrades(grades);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetGradeControllers() {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.resetGradeControllers');
    try {
      return super.resetGradeControllers();
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
targetGrade: ${targetGrade},
courseCode: ${courseCode},
grades: ${grades},
gradeControllers: ${gradeControllers}
    ''';
  }
}
