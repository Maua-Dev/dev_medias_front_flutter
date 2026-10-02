import 'dart:async';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/model/grade.dart';
import 'package:dev_medias_front_flutter/app/service/device_id_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CourseApiException implements Exception {
  final int? statusCode;
  final String message;

  CourseApiException({this.statusCode, required this.message});

  @override
  String toString() => message;
}

/// Limite de matérias custom por device (API).
const int kMaxCustomSubjectsPerDevice = 20;
const String kCustomLimitMessage =
    'Limite de 20 matérias personalizadas atingido neste dispositivo';

class CourseService {
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 20),
    ),
  );
  final DeviceIdService _deviceIdService = deviceIdService;

  Future<Map<String, String>> _deviceHeaders() async {
    final deviceId = await _deviceIdService.getOrCreateDeviceId();
    if (deviceId.isEmpty) {
      throw CourseApiException(message: 'Device ID inválido');
    }
    return {'X-Device-Id': deviceId};
  }

  Future<Map<String, dynamic>> getCourses() async {
    try {
      final headers = await _deviceHeaders();
      final response = await dio.get(
        dotenv.env['API_SUBJECTS']!,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        final subjects = _parseSubjectsPayload(response.data);
        final Map<String, CourseModel> aux = {};

        for (final raw in subjects) {
          final course = courseModelFromApi(raw);
          aux[course.code] = course;
        }

        return aux;
      } else {
        throw CourseApiException(
          statusCode: response.statusCode,
          message: 'Erro na solicitação GET',
        );
      }
    } on DioException catch (e) {
      throw _fromDioException(e);
    } catch (e) {
      if (e is CourseApiException) rethrow;
      throw CourseApiException(message: 'Erro de rede: $e');
    }
  }

  /// POST create-custom-disciplina. Body camelCase; sem deviceId/isCustom.
  Future<CourseModel> createCustomCourse(Map<String, dynamic> body) async {
    final url = _createCustomSubjectUrl();
    if (url == null || url.isEmpty) {
      throw CourseApiException(
        message:
            'API_CREATE_CUSTOM_SUBJECT não configurada. Pare o app e rode `flutter run` de novo após atualizar o .env.',
      );
    }

    try {
      final headers = await _deviceHeaders();
      final payload = _sanitizeCreateBody(body);
      final response = await dio.post(
        url,
        data: payload,
        options: Options(
          headers: {
            ...headers,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (response.data is! Map) {
          throw CourseApiException(
            statusCode: response.statusCode,
            message: 'Resposta inválida ao criar matéria',
          );
        }
        final raw = Map<String, dynamic>.from(response.data as Map);
        return courseModelFromApi(raw);
      }

      throw CourseApiException(
        statusCode: response.statusCode,
        message: _messageFromBody(response.data) ?? 'Erro ao criar matéria',
      );
    } on DioException catch (e) {
      throw _fromDioException(e);
    }
  }

  /// Prefere `API_CREATE_CUSTOM_SUBJECT`; se ausente no asset, deriva de `API_SUBJECTS`.
  String? _createCustomSubjectUrl() =>
      _mssMediasEndpointUrl('API_CREATE_CUSTOM_SUBJECT', 'create-custom-disciplina');

  /// Prefere `API_DELETE_CUSTOM_SUBJECT`; se ausente, deriva de `API_SUBJECTS`.
  String? _deleteCustomSubjectUrl() =>
      _mssMediasEndpointUrl('API_DELETE_CUSTOM_SUBJECT', 'delete-custom-disciplina');

  String? _mssMediasEndpointUrl(String envKey, String endpointName) {
    final configured = dotenv.env[envKey]?.trim();
    if (configured != null && configured.isNotEmpty) return configured;

    final subjects = dotenv.env['API_SUBJECTS']?.trim();
    if (subjects == null || subjects.isEmpty) return null;
    if (subjects.contains('get-all-disciplinas')) {
      return subjects.replaceFirst('get-all-disciplinas', endpointName);
    }
    final trimmed =
        subjects.endsWith('/') ? subjects.substring(0, subjects.length - 1) : subjects;
    final slash = trimmed.lastIndexOf('/');
    final parent = slash >= 0 ? trimmed.substring(0, slash) : trimmed;
    return '$parent/$endpointName';
  }

  /// DELETE delete-custom-disciplina?code=...
  Future<void> deleteCustomCourse(String code) async {
    final url = _deleteCustomSubjectUrl();
    if (url == null || url.isEmpty) {
      throw CourseApiException(
        message:
            'API_DELETE_CUSTOM_SUBJECT não configurada. Pare o app e rode `flutter run` de novo após atualizar o .env.',
      );
    }

    try {
      final headers = await _deviceHeaders();
      final response = await dio.delete(
        url,
        queryParameters: {'code': code},
        options: Options(headers: headers),
      );

      final status = response.statusCode ?? 0;
      // 404 = já não existe / não é deste device — trata como ok para limpar a UI
      if (status == 200 || status == 204 || status == 404) return;

      throw CourseApiException(
        statusCode: status,
        message: _messageFromBody(response.data) ?? 'Erro ao excluir matéria',
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return;
      throw _fromDioException(e);
    }
  }

  /// Remove nulls e campos proibidos (deviceId/isCustom só vêm do header/back).
  Map<String, dynamic> _sanitizeCreateBody(Map<String, dynamic> body) {
    final forbidden = {
      'deviceId',
      'device_id',
      'isCustom',
      'is_custom',
      'studyPlanDownloadPdfUrl',
      'study_plan_download_pdf_url',
      'createdAt',
      'created_at',
      'updatedAt',
      'updated_at',
    };
    final out = <String, dynamic>{};
    body.forEach((key, value) {
      if (value == null) return;
      if (forbidden.contains(key)) return;
      out[key] = value;
    });
    return out;
  }

  CourseApiException _fromDioException(DioException e) {
    final status = e.response?.statusCode;
    final bodyMessage = _messageFromBody(e.response?.data);

    if (status == 409) {
      return CourseApiException(
        statusCode: 409,
        message: bodyMessage ?? 'Já existe uma matéria com esse código',
      );
    }
    if (status == 403) {
      return CourseApiException(
        statusCode: 403,
        message: kCustomLimitMessage,
      );
    }
    if (status == 400) {
      return CourseApiException(
        statusCode: 400,
        message: bodyMessage ?? 'Dados inválidos. Verifique o formulário.',
      );
    }
    if (status != null && status >= 500) {
      return CourseApiException(
        statusCode: status,
        message: bodyMessage ?? 'Erro no servidor. Tente novamente.',
      );
    }
    return CourseApiException(
      statusCode: status,
      message: bodyMessage ?? 'Erro de rede: ${e.message}',
    );
  }

  String? _messageFromBody(dynamic body) {
    if (body is String && body.isNotEmpty) return body;
    if (body is Map) {
      if (body['erro'] != null) return body['erro'].toString();
      if (body['message'] != null) return body['message'].toString();
    }
    return null;
  }

  /// API nova: lista JSON; CDN antigo: mapa indexado por código.
  List<Map<String, dynamic>> _parseSubjectsPayload(dynamic data) {
    if (data is List) {
      return data
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    }
    if (data is Map) {
      return data.entries.map((entry) {
        final subject = Map<String, dynamic>.from(entry.value as Map);
        subject.putIfAbsent('code', () => entry.key.toString());
        return subject;
      }).toList();
    }
    throw Exception('Formato de disciplinas não reconhecido');
  }
}

/// Normaliza snake_case/camelCase da API de disciplinas → [CourseModel].
CourseModel courseModelFromApi(Map<String, dynamic> raw) {
  final course = <String, dynamic>{
    'code': raw['code'],
    'name': raw['name'],
    'period': raw['period'],
    'examWeight': raw['examWeight'] ?? raw['exam_weight'],
    'assignmentWeight': raw['assignmentWeight'] ?? raw['assignment_weight'],
    'exams': raw['exams'] ?? [],
    'assignments': raw['assignments'] ?? [],
    'courses': raw['courses'],
    'examsCode': raw['examsCode'] ?? raw['exams_code'],
    'studyPlanDownloadPdfUrl':
        raw['studyPlanDownloadPdfUrl'] ?? raw['study_plan_download_pdf_url'],
    'isCustom': raw['isCustom'] ?? raw['is_custom'] ?? false,
    'deviceId': raw['deviceId'] ?? raw['device_id'],
    'createdAt': raw['createdAt'] ?? raw['created_at'],
    'updatedAt': raw['updatedAt'] ?? raw['updated_at'],
  };

  final exams = <GradeModel>[];
  for (final exam in course['exams'] as List) {
    exams.add(GradeModel.fromJson(Map<String, dynamic>.from(exam as Map)));
  }
  course['exams'] = exams;

  final assignments = <GradeModel>[];
  for (final assignment in course['assignments'] as List) {
    assignments.add(
        GradeModel.fromJson(Map<String, dynamic>.from(assignment as Map)));
  }
  course['assignments'] = assignments;

  return CourseModel.fromJson(Map<String, Object?>.from(course));
}

CourseService courseService = CourseService();
