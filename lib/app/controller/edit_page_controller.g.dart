// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_page_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditPageController on EditPageControllerBase, Store {
  late final _$targetCalcInProgressAtom = Atom(
      name: 'EditPageControllerBase.targetCalcInProgress', context: context);

  @override
  bool get targetCalcInProgress {
    _$targetCalcInProgressAtom.reportRead();
    return super.targetCalcInProgress;
  }

  @override
  set targetCalcInProgress(bool value) {
    _$targetCalcInProgressAtom.reportWrite(value, super.targetCalcInProgress,
        () {
      super.targetCalcInProgress = value;
    });
  }

  late final _$gradeRenderedAtom =
      Atom(name: 'EditPageControllerBase.gradeRendered', context: context);

  @override
  bool get gradeRendered {
    _$gradeRenderedAtom.reportRead();
    return super.gradeRendered;
  }

  @override
  set gradeRendered(bool value) {
    _$gradeRenderedAtom.reportWrite(value, super.gradeRendered, () {
      super.gradeRendered = value;
    });
  }

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

  late final _$finalScoreTypeAtom =
      Atom(name: 'EditPageControllerBase.finalScoreType', context: context);

  @override
  String get finalScoreType {
    _$finalScoreTypeAtom.reportRead();
    return super.finalScoreType;
  }

  @override
  set finalScoreType(String value) {
    _$finalScoreTypeAtom.reportWrite(value, super.finalScoreType, () {
      super.finalScoreType = value;
    });
  }

  late final _$finalScoreGradeAtom =
      Atom(name: 'EditPageControllerBase.finalScoreGrade', context: context);

  @override
  double? get finalScoreGrade {
    _$finalScoreGradeAtom.reportRead();
    return super.finalScoreGrade;
  }

  @override
  set finalScoreGrade(double? value) {
    _$finalScoreGradeAtom.reportWrite(value, super.finalScoreGrade, () {
      super.finalScoreGrade = value;
    });
  }

  late final _$finalScoreControllerAtom = Atom(
      name: 'EditPageControllerBase.finalScoreController', context: context);

  @override
  TextEditingController get finalScoreController {
    _$finalScoreControllerAtom.reportRead();
    return super.finalScoreController;
  }

  @override
  set finalScoreController(TextEditingController value) {
    _$finalScoreControllerAtom.reportWrite(value, super.finalScoreController,
        () {
      super.finalScoreController = value;
    });
  }

  late final _$gradeTypesAtom =
      Atom(name: 'EditPageControllerBase.gradeTypes', context: context);

  @override
  ObservableMap<String, String> get gradeTypes {
    _$gradeTypesAtom.reportRead();
    return super.gradeTypes;
  }

  @override
  set gradeTypes(ObservableMap<String, String> value) {
    _$gradeTypesAtom.reportWrite(value, super.gradeTypes, () {
      super.gradeTypes = value;
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
  Future<void> calcTargetGrade(
      Map<String, dynamic> grades, Map<String, dynamic> weights) {
    return _$calcTargetGradeAsyncAction
        .run(() => super.calcTargetGrade(grades, weights));
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
  bool getRendered() {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.getRendered');
    try {
      return super.getRendered();
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRendered(bool value) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.setRendered');
    try {
      return super.setRendered(value);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTargetCalcProgress(bool value) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.setTargetCalcProgress');
    try {
      return super.setTargetCalcProgress(value);
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
  void renderTargetGrades(Map<dynamic, dynamic> grades) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.renderTargetGrades');
    try {
      return super.renderTargetGrades(grades);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void renderGrades(Map<dynamic, dynamic> newGrades) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.renderGrades');
    try {
      return super.renderGrades(newGrades);
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
  void calcFinalScore(
      Map<String, dynamic> grades, Map<String, dynamic> weights) {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.calcFinalScore');
    try {
      return super.calcFinalScore(grades, weights);
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Map<String, dynamic> formatGradesForSaving() {
    final _$actionInfo = _$EditPageControllerBaseActionController.startAction(
        name: 'EditPageControllerBase.formatGradesForSaving');
    try {
      return super.formatGradesForSaving();
    } finally {
      _$EditPageControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
targetCalcInProgress: ${targetCalcInProgress},
gradeRendered: ${gradeRendered},
targetGrade: ${targetGrade},
courseCode: ${courseCode},
finalScoreType: ${finalScoreType},
finalScoreGrade: ${finalScoreGrade},
finalScoreController: ${finalScoreController},
gradeTypes: ${gradeTypes},
grades: ${grades},
gradeControllers: ${gradeControllers}
    ''';
  }
}
