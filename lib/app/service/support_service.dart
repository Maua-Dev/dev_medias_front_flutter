import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupportService {

    final Dio dio = Dio();

    Future<Map> postMessage(Map message) async {
    try {
      final response =
          await dio.post(dotenv.env['SUPPORT_URL']!, data: message);
      if (response.statusCode == 200) {
        return message;
      } else {
        throw Exception('Erro na solicitação POST');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}
