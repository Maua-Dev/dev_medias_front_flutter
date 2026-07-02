import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// API nova: lista `[{ "código": "CIC", "nome": "..." }]`.
/// CDN antigo: mapa `{ "CIC": "Ciência da Computação", ... }`.
Map<String, dynamic> parseGraduationsPayload(dynamic data) {
  if (data is List) {
    final result = <String, dynamic>{};
    for (final item in data) {
      final course = Map<String, dynamic>.from(item as Map);
      final code = course['código'] ?? course['codigo'] ?? course['code'];
      final name = course['nome'] ?? course['name'];
      if (code != null && name != null) {
        result[code.toString()] = name.toString();
      }
    }
    if (result.isEmpty) {
      throw Exception('Lista de cursos vazia');
    }
    return result;
  }

  if (data is Map) {
    if (data.containsKey('message')) {
      throw Exception(data['message'].toString());
    }
    return Map<String, dynamic>.from(data);
  }

  throw Exception('Formato de cursos não reconhecido');
}

class GraduationService {
  final Dio dio = Dio();

  Future<Map<String, dynamic>> getGraduations() async {
    try {
      final response = await dio.get(dotenv.env['API_COURSES']!);
      if (response.statusCode == 200) {
        return parseGraduationsPayload(response.data);
      } else {
        throw Exception('Erro na solicitação GET');
      }
    } catch (e) {
      throw Exception('Erro de rede: $e');
    }
  }
}
