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

  late final _$examGradesAtom =
      Atom(name: 'EditPageControllerBase.examGrades', context: context);

  @override
  ObservableMap<String, double> get examGrades {
    _$examGradesAtom.reportRead();
    return super.examGrades;
  }

  @override
  set examGrades(ObservableMap<String, double> value) {
    _$examGradesAtom.reportWrite(value, super.examGrades, () {
      super.examGrades = value;
    });
  }

  late final _$examControllersAtom =
      Atom(name: 'EditPageControllerBase.examControllers', context: context);

  @override
  ObservableMap<String, TextEditingController> get examControllers {
    _$examControllersAtom.reportRead();
    return super.examControllers;
  }

  @override
  set examControllers(ObservableMap<String, TextEditingController> value) {
    _$examControllersAtom.reportWrite(value, super.examControllers, () {
      super.examControllers = value;
    });
  }

  late final _$assignmentGradesAtom =
      Atom(name: 'EditPageControllerBase.assignmentGrades', context: context);

  @override
  ObservableMap<String, double> get assignmentGrades {
    _$assignmentGradesAtom.reportRead();
    return super.assignmentGrades;
  }

  @override
  set assignmentGrades(ObservableMap<String, double> value) {
    _$assignmentGradesAtom.reportWrite(value, super.assignmentGrades, () {
      super.assignmentGrades = value;
    });
  }

  late final _$assignmentControllersAtom = Atom(
      name: 'EditPageControllerBase.assignmentControllers', context: context);

  @override
  ObservableMap<String, TextEditingController> get assignmentControllers {
    _$assignmentControllersAtom.reportRead();
    return super.assignmentControllers;
  }

  @override
  set assignmentControllers(
      ObservableMap<String, TextEditingController> value) {
    _$assignmentControllersAtom.reportWrite(value, super.assignmentControllers,
        () {
      super.assignmentControllers = value;
    });
  }

  late final _$EditPageControllerBaseActionController =
      ActionController(name: 'EditPageControllerBase', context: context);

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
  void buildGrades(CourseModel course) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.buildGrades');
    try {
      return super.buildGrades(course);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buildExamGrades(List<dynamic>? grades) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.buildExamGrades');
    try {
      return super.buildExamGrades(grades);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void buildAssignmentGrades(List<dynamic>? grades) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.buildAssignmentGrades');
    try {
      return super.buildAssignmentGrades(grades);
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
examGrades: ${examGrades},
examControllers: ${examControllers},
assignmentGrades: ${assignmentGrades},
assignmentControllers: ${assignmentControllers}
    ''';
  }
}
