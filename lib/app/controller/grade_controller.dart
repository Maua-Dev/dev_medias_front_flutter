import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/courses_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mobx/mobx.dart';
part 'grade_controller.g.dart';

class GradeController = GradeControllerBase with _$GradeController;

abstract class GradeControllerBase with Store {
  GradeControllerBase();

  final dio = Dio();

  @action
  Future<dynamic> getGrades(String code) async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    final grades =
        box.get('grades', defaultValue: <String, dynamic>{});
    final subjectGrades = grades?[code];
    return subjectGrades;
  }

  @action
  Future<void> insertGrades (String code, Map<String, dynamic> grades) async {
    await Hive.initFlutter();
    var box = await Hive.openBox('user');
    final oldGrades = box.get('grades', defaultValue: <String, Map>{});
    final newGrades = oldGrades;
    newGrades[code] = grades;
    box.put('grades', newGrades);
  }

  @action
  Future<Map<String, dynamic>> getTargetGrades(
      Map<String, dynamic> grades,
      Map<String, dynamic> weights,
      double targetGrade,
      String courseCode) async {
    Map<String, dynamic> gradeMap = {
      "provas_que_tenho": [],
      "trabalhos_que_tenho": [],
      "provas_que_quero": [],
      "trabalhos_que_quero": [],
      "media_desejada": 0
    };
    for (var item in grades.entries) {
      if (item.key[0] == "P") {
        item.value == null
            ? gradeMap["provas_que_quero"].add({
                "peso": weights[item.key] *
                    (coursesController.allCourses![courseCode].examWeight / 100)
              })
            : gradeMap["provas_que_tenho"].add({
                "valor": item.value,
                "peso": weights[item.key] *
                    (coursesController.allCourses![courseCode].examWeight / 100)
              });
      } else {
        item.value == null
            ? gradeMap["trabalhos_que_quero"].add({
                "peso": weights[item.key] *
                    (coursesController
                            .allCourses![courseCode].assignmentWeight /
                        100)
              })
            : gradeMap["trabalhos_que_tenho"].add({
                "valor": item.value,
                "peso": weights[item.key] *
                    (coursesController
                            .allCourses![courseCode].assignmentWeight /
                        100)
              });
      }
    }
    gradeMap["media_desejada"] = targetGrade;
    try {
      final response = await dio.post(
          dotenv.env['GRADE_OPTIMIZER_URL']!,
          data: gradeMap);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Erro na solicitação POST');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}

GradeController gradeController = GradeController();
