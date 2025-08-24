import 'dart:async';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CourseService {
  final Dio dio = Dio();

  Future<Map<String, CourseModel>> getCourses() async {
    try {
      final response = await dio.get(dotenv.env['API_SUBJECTS']!);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        Map<String, CourseModel> aux = {};

        data.forEach((code, course) {
          // Adicionado bloco try-catch para isolar erros de parsing
          try {
            // A sua lógica original é mantida aqui dentro do 'try'
            final prevExams = course["exams"];
            final newExamList = [];
            for (Map<String, dynamic> exam in prevExams) {
              newExamList.add(GradeModel.fromJson(exam));
            }
            course["exams"] = newExamList;

            final prevAssignments = course["assignments"];
            final newAssignmentList = [];
            for (Map<String, dynamic> assignment in prevAssignments) {
              newAssignmentList.add(GradeModel.fromJson(assignment));
            }
            course["assignments"] = newAssignmentList;

            // Esta é a linha que provavelmente causa o erro se os tipos não baterem
            var courseModel = CourseModel.fromJson(course);
            aux[code] = courseModel;

          } catch (error) {
            // Se qualquer parte da lógica acima falhar para um curso específico,
            // o erro será capturado aqui, e o loop continuará para o próximo.
            print('--- ERRO DE PARSING EM UM CURSO ---');
            print('Falha ao processar o curso com o código: $code');
            print('Erro específico: $error');
            print('------------------------------------');
          }
        });

        Map<String, CourseModel> courses = aux;
        return courses;
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}

CourseService courseService = CourseService();