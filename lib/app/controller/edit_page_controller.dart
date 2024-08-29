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
  void buildGrades(List<dynamic>? grades) {
    for (var grade in grades!) {
      gradeControllers[grade.name] = TextEditingController();
      this.grades[grade.name] = null;
    }
  }

  @action
  void resetGradeControllers() {
    grades = ObservableMap<String, double?>.of({});
    gradeControllers = ObservableMap<String, TextEditingController>.of({});
  }

  @action
  Future<Map<String, dynamic>> calcTargetGrade(Map<String, dynamic> grades,
      Map<String, dynamic> weights, double targetGrade) async {
    return await gradeController.getTargetGrade(grades, weights, targetGrade, courseCode);
  }
}

EditPageController editController = EditPageController();
