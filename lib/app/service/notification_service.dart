import 'package:dev_medias_front_flutter/app/model/notice.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotificationService {
  final Dio dio = Dio();

  /// GET [API_NOTIFICATIONS]. Sem URL no `.env`, retorna lista vazia (sem requisição).
  Future<List<NoticeModel>> getNotifications() async {
    final url = dotenv.env['API_NOTIFICATIONS'];
    if (url == null || url.trim().isEmpty) {
      return [];
    }
    try {
      final response = await dio.get(url);
      if (response.statusCode != 200) {
        return [];
      }
      return _parseList(response.data);
    } catch (_) {
      return [];
    }
  }

  List<NoticeModel> _parseList(dynamic data) {
    if (data is List) {
      return data
          .whereType<Map>()
          .map((e) => NoticeModel.fromJson(Map<String, dynamic>.from(e)))
          .where((n) => n.body.trim().isNotEmpty || n.title.trim().isNotEmpty)
          .toList();
    }
    if (data is Map) {
      final nested = data['notifications'] ?? data['data'] ?? data['items'];
      if (nested is List) {
        return _parseList(nested);
      }
      try {
        final single = NoticeModel.fromJson(Map<String, dynamic>.from(data));
        if (single.body.trim().isEmpty && single.title == 'Aviso') {
          return [];
        }
        return [single];
      } catch (_) {
        return [];
      }
    }
    return [];
  }
}
