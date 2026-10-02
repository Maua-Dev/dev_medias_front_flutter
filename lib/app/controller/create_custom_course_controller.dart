import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/service/course_service.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';
part 'create_custom_course_controller.g.dart';

class CreateCustomCourseController = CreateCustomCourseControllerBase
    with _$CreateCustomCourseController;

abstract class CreateCustomCourseControllerBase with Store {
  CreateCustomCourseControllerBase();

  final CourseService _service = courseService;

  @observable
  bool submitting = false;

  @observable
  String? codeError;

  @observable
  String? formError;

  @action
  void clearErrors() {
    codeError = null;
    formError = null;
  }

  /// Backend exige `code`. Se o usuário deixar vazio, gera um id curto.
  String resolveCode(String code, String name) {
    final trimmed = code.trim();
    if (trimmed.isNotEmpty) return trimmed.toUpperCase();

    final slug = name
        .trim()
        .toUpperCase()
        .replaceAll(RegExp(r'[^A-Z0-9]+'), '');
    final prefix =
        slug.isEmpty ? 'CUSTOM' : (slug.length <= 6 ? slug : slug.substring(0, 6));
    final suffix =
        const Uuid().v4().replaceAll('-', '').substring(0, 4).toUpperCase();
    return '$prefix$suffix';
  }

  String? _validatePayload({
    required String name,
    required String resolvedCode,
    required double examWeight,
    required double assignmentWeight,
    required List<Map<String, dynamic>> exams,
    required List<Map<String, dynamic>> assignments,
  }) {
    if (name.isEmpty) return 'Informe o nome da matéria';
    if (resolvedCode.isEmpty) return 'Código inválido';
    if (exams.isEmpty && assignments.isEmpty) {
      return 'Adicione ao menos uma prova ou um trabalho';
    }
    if (examWeight < 0 ||
        examWeight > 1 ||
        assignmentWeight < 0 ||
        assignmentWeight > 1) {
      return 'Pesos de provas/trabalhos devem estar entre 0 e 1';
    }
    if ((examWeight + assignmentWeight - 1.0).abs() > 0.001) {
      return 'Peso de provas + trabalhos deve somar 1';
    }

    for (final item in [...exams, ...assignments]) {
      final itemName = item['name'];
      final weight = item['weight'];
      if (itemName is! String || itemName.trim().isEmpty) {
        return 'Cada prova/trabalho precisa de nome';
      }
      if (weight is! num) {
        return 'Cada prova/trabalho precisa de peso numérico';
      }
    }

    if (exams.isNotEmpty) {
      final sum = exams.fold<double>(
          0, (acc, e) => acc + (e['weight'] as num).toDouble());
      if ((sum - 1.0).abs() > 0.01) {
        return 'Pesos das provas devem somar 1';
      }
    }
    if (assignments.isNotEmpty) {
      final sum = assignments.fold<double>(
          0, (acc, e) => acc + (e['weight'] as num).toDouble());
      if ((sum - 1.0).abs() > 0.01) {
        return 'Pesos dos trabalhos devem somar 1';
      }
    }

    return null;
  }

  void _mergeIntoCatalog(CourseModel course) {
    final catalog = Map<String, dynamic>.from(coursesController.allCourses ?? {});
    catalog[course.code] = course;
    coursesController.setAllCourses(catalog);
  }

  @action
  Future<CourseModel?> submit({
    required String code,
    required String name,
    String period = '',
    double examWeight = 0.5,
    double assignmentWeight = 0.5,
    List<Map<String, dynamic>> exams = const [],
    List<Map<String, dynamic>> assignments = const [],
  }) async {
    clearErrors();
    submitting = true;

    try {
      final trimmedName = name.trim();
      final resolvedCode = resolveCode(code, trimmedName);

      final validationError = _validatePayload(
        name: trimmedName,
        resolvedCode: resolvedCode,
        examWeight: examWeight,
        assignmentWeight: assignmentWeight,
        exams: exams,
        assignments: assignments,
      );
      if (validationError != null) {
        formError = validationError;
        return null;
      }

      // Payload API: camelCase; deviceId/isCustom só no header / resposta.
      final body = <String, dynamic>{
        'code': resolvedCode,
        'name': trimmedName,
        'period': period.trim(),
        'examWeight': examWeight,
        'assignmentWeight': assignmentWeight,
        'exams': exams
            .map((e) => {
                  'name': (e['name'] as String).trim(),
                  'weight': (e['weight'] as num).toDouble(),
                })
            .toList(),
        'assignments': assignments
            .map((e) => {
                  'name': (e['name'] as String).trim(),
                  'weight': (e['weight'] as num).toDouble(),
                })
            .toList(),
        'courses': <String, dynamic>{},
      };

      final created = await _service.createCustomCourse(body);

      // Garante presença no catálogo local (home) mesmo se o refetch falhar.
      _mergeIntoCatalog(created);
      await coursesController.refreshAllSubjects();
      if (coursesController.allCourses?[created.code] == null) {
        _mergeIntoCatalog(created);
      }
      await userController.insertCurrentCourses(created.code);

      return created;
    } on CourseApiException catch (e) {
      if (e.statusCode == 409) {
        codeError = 'Já existe uma matéria com esse código';
      } else if (e.statusCode == 403) {
        formError = kCustomLimitMessage;
      } else {
        formError = e.message;
      }
      return null;
    } catch (e) {
      formError = 'Erro ao criar matéria. Tente novamente.';
      return null;
    } finally {
      submitting = false;
    }
  }
}

CreateCustomCourseController createCustomCourseController =
    CreateCustomCourseController();
