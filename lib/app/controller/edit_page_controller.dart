import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_page_controller.g.dart';

class EditPageController = EditPageControllerBase with _$EditPageController;

abstract class EditPageControllerBase with Store {
  EditPageControllerBase();

  @observable
  double targetGrade = 0;

  @observable
  String courseCode = "";

  @observable
  String finalScoreType = "normal";

  @observable
  double? finalScoreGrade;

  @observable
  TextEditingController finalScoreController = TextEditingController();

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
  double getTargetGrade() {
    return targetGrade;
  }

  @action
  void setTargetGrade(double grade) {
    targetGrade = grade;
  }

  @action
  void renderTargetGrades(Map grades) {
    final allGrades = grades["notas"]["provas"] + grades["notas"]["trabalhos"];
    int index = 0;
    editController.grades.forEach((key, value) {
      if (value == null) {
        value = allGrades[index]["valor"];
        editController.gradeControllers[key]!.text = "$value";
        editController.gradeTypes[key] = "targetcalc";
        index++;
        }
      }
    );
    editController.finalScoreController.text = "$targetGrade";
    editController.finalScoreGrade = targetGrade;
    editController.finalScoreType = "targetcalc";
  }

  @action
  void buildGrades(List<dynamic>? grades) {
    for (var grade in grades!) {
      gradeControllers[grade.name] = TextEditingController();
      gradeTypes[grade.name] = "normal";
      this.grades[grade.name] = null;
    }
  }

  @action
  void resetGradeControllers() {
    grades = ObservableMap<String, double?>.of({});
    finalScoreGrade = null;
    gradeControllers.forEach((key, value) {
      value.dispose();
    });
    finalScoreController.text = "";
    gradeControllers = ObservableMap<String, TextEditingController>.of({});
    finalScoreType = "normal";
    gradeTypes = ObservableMap<String, String>.of({});
  }

  @action
  calcTargetGrade(
      Map<String, dynamic> grades, Map<String, dynamic> weights) async {
    Map targetGrades = await gradeController.getTargetGrades(grades, weights, targetGrade, courseCode);
    renderTargetGrades(targetGrades);
  }
}

EditPageController editController = EditPageController();
