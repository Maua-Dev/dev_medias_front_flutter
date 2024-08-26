import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'edit_page_controller.g.dart';

class EditPageController = EditPageControllerBase with _$EditPageController;

abstract class EditPageControllerBase with Store {
  EditPageControllerBase();

  @observable
  double targetGrade = 0;

  @observable
  ObservableMap<String, double> examGrades =
      ObservableMap<String, double>.of({});

  @observable
  ObservableMap<String, TextEditingController> examControllers =
      ObservableMap<String, TextEditingController>.of({});

  @observable
  ObservableMap<String, double> assignmentGrades =
      ObservableMap<String, double>.of({});

  @observable
  ObservableMap<String, TextEditingController> assignmentControllers =
      ObservableMap<String, TextEditingController>.of({});

  @action
  double getTargetGrade() {
    return targetGrade;
  }

  @action
  void setTargetGrade(double grade) {
    targetGrade = grade;
  }

  @action
  void buildGrades(CourseModel course) {
    buildExamGrades(course.exams);
    buildAssignmentGrades(course.assignments);
  }

  @action
  void buildExamGrades(List<dynamic>? grades) {
    for (var grade in grades!) {
      examControllers[grade.name] = TextEditingController();
      examGrades[grade.name] = 0.0;
    }
  }

  @action
  void buildAssignmentGrades(List<dynamic>? grades) {
    for (var grade in grades!) {
      assignmentControllers[grade.name] = TextEditingController();
      assignmentGrades[grade.name] = 0.0;
    }
  }

  @action
  void resetGradeControllers() {
    examGrades = ObservableMap<String, double>.of({});
    assignmentGrades = ObservableMap<String, double>.of({});
    examControllers = ObservableMap<String, TextEditingController>.of({});
    assignmentControllers = ObservableMap<String, TextEditingController>.of({});
  }
}

EditPageController editController = EditPageController();
