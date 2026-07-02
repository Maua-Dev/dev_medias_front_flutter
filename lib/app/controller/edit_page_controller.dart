import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_page_controller.g.dart';

class EditPageController = EditPageControllerBase with _$EditPageController;

abstract class EditPageControllerBase with Store {
  EditPageControllerBase();

  @observable
  bool targetCalcInProgress = false;

  @observable
  bool gradeRendered = false;

  @observable
  double targetGrade = 0;

  @observable
  String courseCode = "";

  @observable
  String finalScoreType = "normal";

  @observable
  double? finalScoreGrade;

  @observable
  bool targetCalcError = false;

  @observable
  bool finalScoreCalcError = false;

  @observable
  TextEditingController finalScoreController = TextEditingController(text: "");

  @observable
  ObservableMap<String, String> gradeTypes =
      ObservableMap<String, String>.of({});

  @observable
  ObservableMap<String, double?> grades = ObservableMap<String, double?>.of({});

  @observable
  ObservableMap<String, TextEditingController> gradeControllers =
      ObservableMap<String, TextEditingController>.of({});

  @action
  String getCourseCode() {
    return courseCode;
  }

  @action
  void setCourseCode(String code) {
    courseCode = code;
  }

  @action
  bool getRendered() {
    return gradeRendered;
  }

  @action
  void setRendered(bool value) {
    gradeRendered = value;
  }

  @action
  void setTargetCalcProgress(bool value) {
    targetCalcInProgress = value;
  }

  @action
  double getTargetGrade() {
    return targetGrade;
  }

  @action
  void setTargetGrade(double grade) {
    targetGrade = grade;
  }

  @action setTargetCalcError(bool value) {
    targetCalcError = value;
  }

  @action
  void setFinalScoreCalcError(bool value) {
    finalScoreCalcError = value;
  }

  bool _needsTargetFill(String gradeName) {
    return gradeControllers[gradeName]!.text.isEmpty ||
        gradeTypes[gradeName] != 'normal';
  }

  int _filledExamsCount(CourseModel course) {
    var count = 0;
    for (final exam in course.exams ?? <dynamic>[]) {
      if (!_needsTargetFill(exam.name as String)) {
        count++;
      }
    }
    return count;
  }

  int _filledAssignmentsCount(CourseModel course) {
    var count = 0;
    for (final assignment in course.assignments ?? <dynamic>[]) {
      if (!_needsTargetFill(assignment.name as String)) {
        count++;
      }
    }
    return count;
  }

  // Desenha as notas meta na tela
  @action
  bool renderTargetGrades(Map grades) {
    gradeRendered = false;
    targetCalcError = false;

    if (grades.containsKey('erro') ||
        grades['notas'] == null ||
        grades['notas']['provas'] == null ||
        grades['notas']['trabalhos'] == null) {
      targetCalcError = true;
      gradeRendered = true;
      targetCalcInProgress = false;
      return false;
    }

    final course = coursesController.allCourses?[courseCode] as CourseModel?;
    if (course == null) {
      targetCalcError = true;
      gradeRendered = true;
      targetCalcInProgress = false;
      return false;
    }

    final provasMeta = List<Map<String, dynamic>>.from(
      (grades['notas']['provas'] as List).map(
        (item) => Map<String, dynamic>.from(item as Map),
      ),
    );
    final trabalhosMeta = List<Map<String, dynamic>>.from(
      (grades['notas']['trabalhos'] as List).map(
        (item) => Map<String, dynamic>.from(item as Map),
      ),
    );

    var provaQueroIndex = 0;
    var trabalhoQueroIndex = 0;
    final provasTenho = _filledExamsCount(course);
    final trabalhosTenho = _filledAssignmentsCount(course);

    for (final exam in course.exams ?? <dynamic>[]) {
      final name = exam.name as String;
      if (!_needsTargetFill(name)) {
        continue;
      }
      final responseIndex = provasTenho + provaQueroIndex;
      if (responseIndex >= provasMeta.length) {
        targetCalcError = true;
        gradeRendered = true;
        targetCalcInProgress = false;
        return false;
      }
      final valor = (provasMeta[responseIndex]['valor'] as num).toDouble();
      grades[name] = valor;
      gradeControllers[name]!.text = '$valor';
      gradeTypes[name] = 'targetcalc';
      provaQueroIndex++;
    }

    for (final assignment in course.assignments ?? <dynamic>[]) {
      final name = assignment.name as String;
      if (!_needsTargetFill(name)) {
        continue;
      }
      final responseIndex = trabalhosTenho + trabalhoQueroIndex;
      if (responseIndex >= trabalhosMeta.length) {
        targetCalcError = true;
        gradeRendered = true;
        targetCalcInProgress = false;
        return false;
      }
      final valor = (trabalhosMeta[responseIndex]['valor'] as num).toDouble();
      grades[name] = valor;
      gradeControllers[name]!.text = '$valor';
      gradeTypes[name] = 'targetcalc';
      trabalhoQueroIndex++;
    }

    finalScoreController.text = '$targetGrade';
    finalScoreGrade = targetGrade;
    finalScoreType = 'targetcalc';
    gradeRendered = true;
    targetCalcInProgress = false;
    return true;
  }

  @action
  void renderGrades(Map newGrades) {
    gradeRendered = false;
    editController.grades.forEach((key, value) {
      if (newGrades[key] != null && newGrades[key]["value"] != null) {
          editController.grades[key] = newGrades[key]["value"];
          editController.gradeControllers[key]!.text = "${newGrades[key]["value"]}";
          editController.gradeTypes[key] = newGrades[key]["type"];
          }
        }
      );
    if (newGrades["finalScore"] != null && newGrades["finalScore"]["value"] != null) {
      editController.finalScoreGrade = newGrades["finalScore"]["value"];
      editController.finalScoreController.text = "${newGrades["finalScore"]["value"]}";
      editController.finalScoreType = newGrades["finalScore"]["type"];
    }
    gradeRendered = true;
  }

  // De acordo com as notas recebidas como parâmetro, cria os controladores de notas
  @action
  void buildGrades(List<dynamic>? grades) {
    for (var grade in grades!) {
      gradeControllers[grade.name] = TextEditingController(text: "");
      gradeTypes[grade.name] = "normal";
      this.grades[grade.name] = null;
    }
  }

  // Reseta os controladores de notas para comportar as notas de outra matéria
  @action
  void resetGradeControllers() {
    grades = ObservableMap<String, double?>.of({});
    finalScoreGrade = null;
    finalScoreType = "normal";
    finalScoreController = TextEditingController(text: "");
    gradeControllers.forEach((key, value) {
      value.dispose();
    });
    gradeControllers = ObservableMap<String, TextEditingController>.of({});
    gradeTypes = ObservableMap<String, String>.of({});
  }

  // Calcula as metas de nota para cada avaliação de acordo com a meta inserida com o usuário
  @action
  Future<bool> calcTargetGrade(
      Map<String, dynamic> grades, Map<String, dynamic> weights) async {
    setTargetCalcError(false);

    final filteredGrades = Map<String, dynamic>.from(grades);
    filteredGrades.forEach((key, value) {
      if (gradeTypes[key] != "normal") {
        filteredGrades[key] = null;
      }
    });

    final targetGrades = await gradeController.getTargetGrades(
      filteredGrades,
      weights,
      targetGrade.toDouble(),
      courseCode,
    );

    return renderTargetGrades(targetGrades);
  }

  @action
  void eraseTargetGrades() {
    gradeTypes.forEach((key, value) {
      if (value == "targetcalc") {
        grades[key] = null;
        gradeControllers[key]!.text = "";
        gradeTypes[key] = "normal";
      }
    });
    if (finalScoreType == "targetcalc") {
      finalScoreGrade = null;
      finalScoreController.text = "";
      finalScoreType = "normal";
    }
    final formattedGrades = editController.formatGradesForSaving();
    gradeController.insertGrades(editController.getCourseCode(), formattedGrades);
  }

  // Calcula a nota final de acordo com as notas inseridas pelo usuário
  @action
  Future<bool> calcFinalScore(
      Map<String, dynamic> weights, Map<String, dynamic> grades) async {
    setFinalScoreCalcError(false);

    final result =
        await gradeController.getFinalScore(grades, weights, courseCode);

    if (result.containsKey('erro')) {
      finalScoreCalcError = true;
      finalScoreGrade = null;
      finalScoreController.text = '';
      return false;
    }

    finalScoreGrade = (result['media'] as num?)?.toDouble();
    finalScoreController.text =
        finalScoreGrade != null ? '$finalScoreGrade' : '';
    finalScoreType = 'normal';
    return true;
  }

  // Formata as notas para serem enviadas ao salvamento local no Hive
  @action
  Map<String, dynamic> formatGradesForSaving () {
    Map<String, dynamic> formattedGrades = {};
    for (var grade in grades.keys) {
      formattedGrades[grade] = {"value": grades[grade], "type": gradeTypes[grade]};
    }
    formattedGrades["finalScore"] = {"value": finalScoreGrade, "type": finalScoreType};
    return formattedGrades;
  }
}

EditPageController editController = EditPageController();
