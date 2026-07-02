import 'package:dev_medias_front_flutter/app/service/grade_api_payload.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SupportService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> postMessage(Map<String, dynamic> message) async {
    try {
      final response =
          await dio.post(dotenv.env['API_SUPPORT_URL']!, data: message);
      if (response.statusCode == 200) {
        return {'success': true};
      }
      return {
        'success': false,
        'error': errorMessageFromApiBody(response.data) ??
            'Erro na solicitação POST (${response.statusCode})',
      };
    } on DioException catch (e) {
      final error = errorMessageFromApiBody(e.response?.data) ??
          e.message ??
          'Erro de rede';
      return {'success': false, 'error': error};
    } catch (e) {
      return {'success': false, 'error': 'Erro de rede: $e'};
    }
  }
}
