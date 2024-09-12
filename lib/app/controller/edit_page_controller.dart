import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
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

  // Desenha as notas meta na tela
  @action
  void renderTargetGrades(Map grades) {
    setRendered(false);
    final allGrades = grades["notas"]["provas"] + grades["notas"]["trabalhos"];
    int index = 0;
    // Define os valores das notas restantes como as metas recebidas
    editController.grades.forEach((key, value) {
      if (editController.gradeControllers[key]!.text.isEmpty || editController.gradeTypes[key] != "normal") {
        editController.grades[key] = allGrades[index]["valor"];
        editController.gradeControllers[key]!.text = "${allGrades[index]["valor"]}";
        editController.gradeTypes[key] = "targetcalc";
        index++;
        }
      }
    );
    // Faz o mesmo para a nota final
    editController.finalScoreController.text = "$targetGrade";
    editController.finalScoreGrade = targetGrade;
    editController.finalScoreType = "targetcalc";
    setRendered(true);
  }

  @action
  void renderGrades(Map newGrades) {
    setRendered(false);
    editController.grades.forEach((key, value) {
      if (newGrades[key]["value"] != null) {
          editController.grades[key] = newGrades[key]["value"];
          editController.gradeControllers[key]!.text = "${newGrades[key]["value"]}";
          editController.gradeTypes[key] = newGrades[key]["type"];
          }
        }
      );
    if (newGrades["finalScore"]["value"] != null) {
      editController.finalScoreGrade = newGrades["finalScore"]["value"];
      editController.finalScoreController.text = "${newGrades["finalScore"]["value"]}";
      editController.finalScoreType = newGrades["finalScore"]["type"];
    }
    setRendered(true);
  }

  // De acordo com as notas recebias como parâmetro, cria os controladores de notas
  @action
  void buildGrades(List<dynamic>? grades) {
    for (var grade in grades!) {
      gradeControllers[grade.name] = TextEditingController();
      gradeTypes[grade.name] = "normal";
      this.grades[grade.name] = null;
    }
  }

  // Reseta os controladores de notas para comportar as notas de outra matéria
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

  // Calcula as metas de nota para cada avaliação de acordo com a meta inserida com o usuário
  @action
  Future<void> calcTargetGrade(
      Map<String, dynamic> grades, Map<String, dynamic> weights) async {
    // Se o tipo de uma das notas for diferente de normal, ele é considerado como zero
    final filteredGrades = grades;
    filteredGrades.forEach((key, value) {
      if (gradeTypes[key] != "normal") {
        filteredGrades[key] = null;
      }
    });
    // Obtém as notas meta e devolve um mapa
    Map targetGrades = await gradeController.getTargetGrades(filteredGrades, weights, targetGrade.toDouble(), courseCode);
    // Pega o mapa e utiliza ele para alterar os valores da tela
    renderTargetGrades(targetGrades);
  }

  // Calcula a nota final de acordo com as notas inseridas pelo usuário
  @action
  void calcFinalScore(Map<String, dynamic> grades, Map<String, dynamic> weights) {
    // Arrendonda número para o múltiplo de 0.5 mais próximo
    double roundToNearestHalf(double number) {
      return (number * 2).round() / 2;
    }

    // Calcula a nota final
    final auxGrades = {...grades};
    auxGrades.forEach((key, value) {
      if (value == null || gradeTypes[key] != "normal") {
        auxGrades[key] = 0.0;
      }
    });

    double productSum = 0;
    double weightSum = 0;

    auxGrades.forEach((key, grade) {
      double weight = weights[key] ?? 0;
      productSum += grade * weight;
      weightSum += weight;
    });

    if (weightSum == 0) {
      throw ArgumentError('A soma dos pesos não pode ser zero.');
    }

    final result = roundToNearestHalf(productSum / weightSum);

    // Atualiza o resultado final na tela
    finalScoreController.text = "$result";
    finalScoreGrade = result;
    finalScoreType = "normal";
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
