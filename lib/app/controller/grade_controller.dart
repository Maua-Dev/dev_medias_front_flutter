import 'dart:async';
import 'package:dev_medias_front_flutter/app/controller/courses_controller.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'grade_controller.g.dart';

class GradeController = GradeControllerBase with _$GradeController;

abstract class GradeControllerBase with Store {
  GradeControllerBase();

  final dio = Dio();

  @action
  Future<Map<String, dynamic>> getTargetGrade(Map<String, dynamic> grades,
      Map<String, dynamic> weights, double targetGrade, String courseCode) async {
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
            ? gradeMap["provas_que_quero"].add({"peso": weights[item.key]*(coursesController.allCourses![courseCode].examWeight/100)})
            : gradeMap["provas_que_tenho"].add({
                "valor": item.value,
                "peso": weights[item.key]*(coursesController.allCourses![courseCode].examWeight/100)
              });
      } else {
        item.value == null
            ? gradeMap["trabalhos_que_quero"].add({"peso": weights[item.key]*(coursesController.allCourses![courseCode].assignmentWeight/100)})
            : gradeMap["trabalhos_que_tenho"].add({
                "valor": item.value,
                "peso": weights[item.key]*(coursesController.allCourses![courseCode].assignmentWeight/100)
              });
      }
    }
    gradeMap["media_desejada"] = targetGrade;
    print(gradeMap);
    try {
      final response = await dio.post(
          "https://10rp5zrm1j.execute-api.sa-east-1.amazonaws.com/prod/mss-medias/grade-optmizer",
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
