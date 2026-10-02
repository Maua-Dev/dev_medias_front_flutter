import 'package:dev_medias_front_flutter/app/controller/create_custom_course_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/navigation_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class _GradeRow {
  final TextEditingController nameController;
  final TextEditingController weightController;

  _GradeRow({String name = '', String weight = '1'})
      : nameController = TextEditingController(text: name),
        weightController = TextEditingController(text: weight);

  void dispose() {
    nameController.dispose();
    weightController.dispose();
  }

  Map<String, dynamic>? toPayload() {
    final name = nameController.text.trim();
    if (name.isEmpty) return null;
    final weight =
        double.tryParse(weightController.text.trim().replaceAll(',', '.'));
    if (weight == null) return null;
    return {'name': name, 'weight': weight};
  }
}

class CreateCustomCoursePage extends StatefulWidget {
  const CreateCustomCoursePage({super.key});

  @override
  State<CreateCustomCoursePage> createState() => _CreateCustomCoursePageState();
}

class _CreateCustomCoursePageState extends State<CreateCustomCoursePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _codeController = TextEditingController();
  final _periodController = TextEditingController();
  final _examWeightController = TextEditingController(text: '1');
  final _assignmentWeightController = TextEditingController(text: '0');
  final _codeFocus = FocusNode();

  final List<_GradeRow> _exams = [_GradeRow(name: 'P1', weight: '1')];
  final List<_GradeRow> _assignments = [];

  bool _syncingComponentWeights = false;
  String? _localFormError;

  @override
  void initState() {
    super.initState();
    _examWeightController.addListener(_onExamWeightEdited);
    _assignmentWeightController.addListener(_onAssignmentWeightEdited);
    _syncComponentWeightsFromLists();
  }

  @override
  void dispose() {
    _examWeightController.removeListener(_onExamWeightEdited);
    _assignmentWeightController.removeListener(_onAssignmentWeightEdited);
    _nameController.dispose();
    _codeController.dispose();
    _periodController.dispose();
    _examWeightController.dispose();
    _assignmentWeightController.dispose();
    _codeFocus.dispose();
    for (final row in _exams) {
      row.dispose();
    }
    for (final row in _assignments) {
      row.dispose();
    }
    super.dispose();
  }

  String _formatWeight(double value) {
    final clamped = value.clamp(0.0, 1.0);
    if ((clamped * 1000).round() % 10 == 0 &&
        (clamped * 100).round() % 10 == 0) {
      final asFixed1 = clamped.toStringAsFixed(1);
      if (asFixed1.endsWith('.0')) {
        return clamped.toStringAsFixed(0);
      }
      return asFixed1;
    }
    return clamped
        .toStringAsFixed(3)
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '');
  }

  double? _parseWeight(String raw) {
    return double.tryParse(raw.trim().replaceAll(',', '.'));
  }

  void _redistributeEqual(List<_GradeRow> rows) {
    if (rows.isEmpty) return;
    final n = rows.length;
    final each = 1.0 / n;
    for (var i = 0; i < n; i++) {
      final weight = i == n - 1 ? (1.0 - each * (n - 1)) : each;
      rows[i].weightController.text = _formatWeight(weight);
    }
  }

  void _syncComponentWeightsFromLists() {
    _syncingComponentWeights = true;
    if (_exams.isEmpty && _assignments.isEmpty) {
      _examWeightController.text = '0';
      _assignmentWeightController.text = '0';
    } else if (_exams.isEmpty) {
      _examWeightController.text = '0';
      _assignmentWeightController.text = '1';
    } else if (_assignments.isEmpty) {
      _examWeightController.text = '1';
      _assignmentWeightController.text = '0';
    } else {
      // Mantém o valor atual de provas se já válido; senão 0.5/0.5
      final exam = _parseWeight(_examWeightController.text);
      if (exam == null || exam <= 0 || exam >= 1) {
        _examWeightController.text = '0.5';
        _assignmentWeightController.text = '0.5';
      } else {
        _assignmentWeightController.text = _formatWeight(1.0 - exam);
      }
    }
    _syncingComponentWeights = false;
  }

  void _onExamWeightEdited() {
    if (_syncingComponentWeights) return;
    if (_exams.isEmpty || _assignments.isEmpty) return;

    final exam = _parseWeight(_examWeightController.text);
    if (exam == null) return;
    final clamped = exam.clamp(0.0, 1.0);
    _syncingComponentWeights = true;
    if (clamped != exam) {
      _examWeightController.text = _formatWeight(clamped);
    }
    _assignmentWeightController.text = _formatWeight(1.0 - clamped);
    _syncingComponentWeights = false;
  }

  void _onAssignmentWeightEdited() {
    if (_syncingComponentWeights) return;
    if (_exams.isEmpty || _assignments.isEmpty) return;

    final assignment = _parseWeight(_assignmentWeightController.text);
    if (assignment == null) return;
    final clamped = assignment.clamp(0.0, 1.0);
    _syncingComponentWeights = true;
    if (clamped != assignment) {
      _assignmentWeightController.text = _formatWeight(clamped);
    }
    _examWeightController.text = _formatWeight(1.0 - clamped);
    _syncingComponentWeights = false;
  }

  void _addExam() {
    setState(() {
      _exams.add(_GradeRow(name: 'P${_exams.length + 1}'));
      _redistributeEqual(_exams);
      _syncComponentWeightsFromLists();
    });
  }

  void _removeExam(int index) {
    setState(() {
      _exams[index].dispose();
      _exams.removeAt(index);
      _redistributeEqual(_exams);
      _syncComponentWeightsFromLists();
    });
  }

  void _addAssignment() {
    setState(() {
      _assignments.add(_GradeRow(name: 'T${_assignments.length + 1}'));
      _redistributeEqual(_assignments);
      _syncComponentWeightsFromLists();
    });
  }

  void _removeAssignment(int index) {
    setState(() {
      _assignments[index].dispose();
      _assignments.removeAt(index);
      _redistributeEqual(_assignments);
      _syncComponentWeightsFromLists();
    });
  }

  bool get _canEditComponentSplit =>
      _exams.isNotEmpty && _assignments.isNotEmpty;

  String? _validateBeforeSubmit() {
    final name = _nameController.text.trim();
    if (name.isEmpty) return 'Informe o nome da matéria';

    if (_exams.isEmpty && _assignments.isEmpty) {
      return 'Adicione ao menos uma prova ou um trabalho';
    }

    for (final exam in _exams) {
      if (exam.nameController.text.trim().isEmpty) {
        return 'Todas as provas precisam de nome';
      }
    }
    for (final assignment in _assignments) {
      if (assignment.nameController.text.trim().isEmpty) {
        return 'Todos os trabalhos precisam de nome';
      }
    }

    final examWeight = _parseWeight(_examWeightController.text);
    final assignmentWeight = _parseWeight(_assignmentWeightController.text);
    if (examWeight == null || assignmentWeight == null) {
      return 'Pesos de provas/trabalhos inválidos';
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

    if (_exams.isNotEmpty) {
      final examPayloads =
          _exams.map((e) => e.toPayload()).whereType<Map<String, dynamic>>();
      if (examPayloads.length != _exams.length) {
        return 'Pesos das provas inválidos';
      }
      final sum = examPayloads.fold<double>(
          0, (acc, e) => acc + (e['weight'] as num).toDouble());
      if ((sum - 1.0).abs() > 0.01) {
        return 'Pesos das provas devem somar 1';
      }
    }

    if (_assignments.isNotEmpty) {
      final assignmentPayloads = _assignments
          .map((e) => e.toPayload())
          .whereType<Map<String, dynamic>>();
      if (assignmentPayloads.length != _assignments.length) {
        return 'Pesos dos trabalhos inválidos';
      }
      final sum = assignmentPayloads.fold<double>(
          0, (acc, e) => acc + (e['weight'] as num).toDouble());
      if ((sum - 1.0).abs() > 0.01) {
        return 'Pesos dos trabalhos devem somar 1';
      }
    }

    return null;
  }

  Future<void> _onSubmit() async {
    createCustomCourseController.clearErrors();
    setState(() => _localFormError = null);

    if (!_formKey.currentState!.validate()) return;

    _syncComponentWeightsFromLists();

    final validationError = _validateBeforeSubmit();
    if (validationError != null) {
      setState(() => _localFormError = validationError);
      return;
    }

    final examWeight = _parseWeight(_examWeightController.text)!;
    final assignmentWeight = _parseWeight(_assignmentWeightController.text)!;

    final exams = _exams
        .map((e) => e.toPayload())
        .whereType<Map<String, dynamic>>()
        .toList();
    final assignments = _assignments
        .map((e) => e.toPayload())
        .whereType<Map<String, dynamic>>()
        .toList();

    final created = await createCustomCourseController.submit(
      code: _codeController.text,
      name: _nameController.text,
      period: _periodController.text,
      examWeight: examWeight,
      assignmentWeight: assignmentWeight,
      exams: exams,
      assignments: assignments,
    );

    if (!mounted) return;

    if (createCustomCourseController.codeError != null) {
      _codeFocus.requestFocus();
      return;
    }

    final formError = createCustomCourseController.formError;
    if (formError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(formError)),
      );
      return;
    }

    if (created != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Matéria criada com sucesso')),
      );
      Navigator.of(context).pop(true);
    }
  }

  InputDecoration _fieldDecoration({
    String? hint,
    String? errorText,
    bool enabled = true,
    bool readOnlyLook = false,
  }) {
    final muted = !enabled || readOnlyLook;
    return InputDecoration(
      hintText: hint,
      errorText: errorText,
      hintStyle: TextStyle(
        fontSize: 16,
        color: muted ? AppColors.textFaded.withValues(alpha: 0.6) : AppColors.textFaded,
      ),
      fillColor: muted ? const Color(0xFFBDBDBD) : AppColors.white,
      filled: true,
      border: OutlineInputBorder(
        borderRadius: Round.primary,
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: Round.primary,
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );
  }

  Widget _sectionTitle(String text, {bool muted = false}) {
    return Padding(
      padding: const EdgeInsets.only(top: 18, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          color: muted ? AppColors.gray : AppColors.white,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _componentWeightField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required String lockedHint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text(
            label,
            style: TextStyle(
              color: enabled ? AppColors.white : AppColors.gray,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          enabled: enabled,
          readOnly: !enabled,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
          ],
          style: TextStyle(
            fontSize: 16,
            color: enabled ? AppColors.black : AppColors.textFaded,
            fontWeight: enabled ? FontWeight.w600 : FontWeight.w400,
          ),
          decoration: _fieldDecoration(
            hint: enabled ? null : lockedHint,
            enabled: enabled,
          ),
        ),
      ],
    );
  }

  Widget _gradeList({
    required String title,
    required List<_GradeRow> rows,
    required VoidCallback onAdd,
    required void Function(int index) onRemove,
  }) {
    final empty = rows.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: _sectionTitle(title, muted: empty)),
            IconButton(
              onPressed: onAdd,
              tooltip: 'Adicionar',
              icon: Icon(
                Icons.add_circle,
                color: empty ? AppColors.white : AppColors.white,
              ),
            ),
          ],
        ),
        if (empty)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.backgroundLight,
              borderRadius: Round.primary,
              border: Border.all(color: const Color(0xFF5A4A75)),
            ),
            child: const Text(
              'Nenhum item ainda — toque em + para adicionar',
              style: TextStyle(color: AppColors.gray, fontSize: 13),
            ),
          ),
        ...List.generate(rows.length, (index) {
          final row = rows[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    controller: row.nameController,
                    style: const TextStyle(fontSize: 16, color: AppColors.black),
                    decoration: _fieldDecoration(hint: 'Nome'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    controller: row.weightController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                    ],
                    style: const TextStyle(fontSize: 16, color: AppColors.black),
                    decoration: _fieldDecoration(hint: 'Peso'),
                  ),
                ),
                IconButton(
                  onPressed: () => onRemove(index),
                  tooltip: 'Remover',
                  icon: const Icon(Icons.remove_circle_outline,
                      color: AppColors.white),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Column(
                children: [
                  const NavigationTopBar(prevPage: '/add'),
                  const SizedBox(height: 12),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Criar matéria personalizada',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
             
                  const SizedBox(height: 8),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: [
                          _sectionTitle('Nome *'),
                          TextFormField(
                            controller: _nameController,
                            style: const TextStyle(
                                fontSize: 18, color: AppColors.black),
                            decoration:
                                _fieldDecoration(hint: 'Ex.: Minha matéria'),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty) {
                                return 'Informe o nome';
                              }
                              return null;
                            },
                          ),
                          _sectionTitle('Peso provas / trabalhos'),
                          Row(
                            children: [
                              Expanded(
                                child: _componentWeightField(
                                  label: 'Provas',
                                  controller: _examWeightController,
                                  enabled: _canEditComponentSplit,
                                  lockedHint: _assignments.isEmpty
                                      ? 'Automático'
                                      : 'Sem provas',
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: _componentWeightField(
                                  label: 'Trabalhos',
                                  controller: _assignmentWeightController,
                                  enabled: _canEditComponentSplit,
                                  lockedHint: _exams.isEmpty
                                      ? 'Automático'
                                      : 'Add trabalhos',
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              _canEditComponentSplit
                                  ? 'Provas + trabalhos sempre somam 1.'
                                  : _assignments.isEmpty && _exams.isNotEmpty
                                      ? 'Adicione um trabalho para liberar a divisão de pesos.'
                                      : _exams.isEmpty &&
                                              _assignments.isNotEmpty
                                          ? 'Adicione uma prova para liberar a divisão de pesos.'
                                          : 'Adicione provas e/ou trabalhos abaixo.',
                              style: TextStyle(
                                color: _canEditComponentSplit
                                    ? AppColors.gray
                                    : const Color(0xFFFFCC80),
                                fontSize: 12,
                              ),
                            ),
                          ),
                          _gradeList(
                            title: 'Provas',
                            rows: _exams,
                            onAdd: _addExam,
                            onRemove: _removeExam,
                          ),
                          _gradeList(
                            title: 'Trabalhos',
                            rows: _assignments,
                            onAdd: _addAssignment,
                            onRemove: _removeAssignment,
                          ),
                          _sectionTitle('Período (opcional)'),
                          TextFormField(
                            controller: _periodController,
                            style: const TextStyle(
                                fontSize: 18, color: AppColors.black),
                            decoration: _fieldDecoration(hint: 'Ex.: 2026.1'),
                          ),
                          _sectionTitle('Código (opcional)'),
                          Observer(builder: (_) {
                            return TextFormField(
                              controller: _codeController,
                              focusNode: _codeFocus,
                              textCapitalization: TextCapitalization.characters,
                              style: const TextStyle(
                                  fontSize: 18, color: AppColors.black),
                              decoration: _fieldDecoration(
                                hint: 'Gerado automaticamente se vazio',
                                errorText:
                                    createCustomCourseController.codeError,
                              ),
                              onChanged: (_) {
                                if (createCustomCourseController.codeError !=
                                    null) {
                                  createCustomCourseController.clearErrors();
                                }
                              },
                            );
                          }),
                          if (_localFormError != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                _localFormError!,
                                style: const TextStyle(
                                  color: Color(0xFFFF8A80),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          Observer(builder: (_) {
                            final error =
                                createCustomCourseController.formError;
                            if (error == null) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                error,
                                style: const TextStyle(
                                  color: Color(0xFFFF8A80),
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 24),
                          Observer(builder: (_) {
                            final submitting =
                                createCustomCourseController.submitting;
                            return ElevatedButton(
                              onPressed: submitting ? null : _onSubmit,
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.red,
                                disabledBackgroundColor:
                                    AppColors.backgroundLight,
                                shape: RoundedRectangleBorder(
                                    borderRadius: Round.primary),
                                minimumSize: const Size.fromHeight(52),
                              ),
                              child: submitting
                                  ? const SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.white,
                                      ),
                                    )
                                  : const Text(
                                      'Salvar',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                            );
                          }),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
