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
  bool targetCalcError = false;

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

  // Desenha as notas meta na tela
  @action
  void renderTargetGrades(Map grades) {
    gradeRendered = false;
    if (grades.containsKey("erro")) {
      targetCalcError = true;
      gradeRendered = true;
      targetCalcInProgress = false;
      return;
    }
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
    gradeRendered = true;
    targetCalcInProgress = false;
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
    Map targetGrades = {};
    try {
        targetGrades = await gradeController.getTargetGrades(filteredGrades, weights, targetGrade.toDouble(), courseCode);
    } catch (e) {
        targetGrades = {"erro": "Erro ao calcular as notas meta."};
    }

    // Pega o mapa e utiliza ele para alterar os valores da tela
    renderTargetGrades(targetGrades);
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
  Future<void> calcFinalScore(Map<String, dynamic> weights, Map<String, dynamic> grades) async {


    try {
      Map result = await gradeController.getFinalScore(grades, weights, courseCode);
      finalScoreGrade = result["media"];
    } catch (e) {
      finalScoreGrade = null;
    }

    // Atualiza o resultado final na tela
    finalScoreController.text = finalScoreGrade != null ? "$finalScoreGrade" : "";
    finalScoreGrade = finalScoreGrade;
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
