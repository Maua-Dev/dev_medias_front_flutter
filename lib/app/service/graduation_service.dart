import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GraduationService {

    final Dio dio = Dio();

    Future<Map<String, dynamic>> getGraduations() async {
    try {
      final response =
          await dio.get(dotenv.env['GRADS_URL']!);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        return data;
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}
