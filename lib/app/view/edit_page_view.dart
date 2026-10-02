import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/service/grade_api_payload.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/grade_input.dart';
import 'package:dev_medias_front_flutter/app/widgets/grade_input_row.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/navigation_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class EditPage extends StatefulWidget {
  final CourseModel course;

  const EditPage({super.key, required this.course});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final ScrollController _gradesScrollController = ScrollController();

  static const _mediaBoxColor = Color(0xFFECE6F5);

  @override
  void initState() {
    initializeAsync();
    super.initState();
  }

  @override
  void dispose() {
    _gradesScrollController.dispose();
    super.dispose();
  }

  bool get _hasNoGrades =>
      (widget.course.assignments?.isEmpty ?? true) &&
      (widget.course.exams?.isEmpty ?? true);

  void _scrollGradesToBottom() {
    if (!_gradesScrollController.hasClients) return;
    _gradesScrollController.animateTo(
      _gradesScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
    );
  }

  Future<void> initializeAsync() async {
    final grades = widget.course.exams! + widget.course.assignments!;
    editController.resetGradeControllers();
    editController.setCourseCode(widget.course.code);
    editController.buildGrades(grades);
    final savedGrades = await gradeController.getGrades(widget.course.code);
    if (savedGrades != null) {
      editController.renderGrades(savedGrades);
    } else {
      final gradesJson = grades.map((grade) => grade.toJson()).toList();
      final defaultMap = {};
      for (var grade in gradesJson) {
        defaultMap[grade["name"]] = {"value": null, "type": "normal"};
      }
      editController.renderGrades(defaultMap);
    }
    editController.setRendered(true);
  }

  @override
  Widget build(BuildContext context) {
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                isKeyboardVisible
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top)),
                //Top Barra de Navegação
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: isKeyboardVisible
                      ? Container()
                      : const NavigationTopBar(
                          prevPage: '/home',
                        ),
                ),
                // Cabeçalho Matéria (redesign)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: Round.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.course.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                GestureDetector(
                                  onTap: () => _showExamsCodeInfo(context),
                                  child: Text(
                                    '${widget.course.code} · ${hasExamsCode(widget.course) ? widget.course.examsCode! : 'Sem critério'}',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: hasExamsCode(widget.course)
                                          ? FontStyle.normal
                                          : FontStyle.italic,
                                      color: AppColors.textFaded,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            visualDensity: VisualDensity.compact,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            tooltip: hasStudyPlanPdf(widget.course)
                                ? 'Abrir plano de ensino'
                                : 'Plano de ensino indisponível',
                            icon: Icon(
                              LucideIcons.fileText,
                              color: hasStudyPlanPdf(widget.course)
                                  ? AppColors.red
                                  : AppColors.gray,
                              size: 26,
                            ),
                            onPressed: hasStudyPlanPdf(widget.course)
                                ? () => _openStudyPlanPdf(widget.course)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
 
                // Menu Matéria (redesign)
                Observer(
                  builder: (_) => Container(
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: Round.primary),
                      child: editController.gradeRendered &&
                              editController.targetCalcInProgress == false
                          ? AnimatedContainer(
                              height: MediaQuery.of(context).size.height -
                                  (isKeyboardVisible ? 520 : 400),
                              duration: const Duration(milliseconds: 300),
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    controller: _gradesScrollController,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 16, 20, 72),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Expanded(
                                              child: Text(
                                                'Suas notas',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors.black,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              tooltip: 'Definições da matéria',
                                              icon: const Icon(
                                                LucideIcons.bookOpen,
                                                color: AppColors.red,
                                                size: 22,
                                              ),
                                              onPressed: () {
                                                _showCourseDefinitions(
                                                    context, widget.course);
                                              },
                                            ),
                                            const SizedBox(width: 4),
                                            IconButton(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              padding: EdgeInsets.zero,
                                              constraints:
                                                  const BoxConstraints(),
                                              tooltip: 'Limpar notas de meta',
                                              icon: const Icon(
                                                LucideIcons.pencil,
                                                color: AppColors.red,
                                                size: 22,
                                              ),
                                              onPressed: _hasNoGrades
                                                  ? null
                                                  : () {
                                                      _showErasePopup(
                                                          context,
                                                          widget.course);
                                                    },
                                            ),
                                          ],
                                        ),
                                        if (_hasNoGrades)
                                          const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 40),
                                            child: Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                'Essa matéria não tem notas cadastradas.',
                                                style: TextStyle(
                                                  color: AppColors.textFaded,
                                                ),
                                              ),
                                            ),
                                          ),
                                        if (widget.course.exams!.isNotEmpty) ...[
                                          const SizedBox(height: 16),
                                          const Text(
                                            'PROVAS',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.8,
                                              color: AppColors.textFaded,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          ...List.generate(
                                            widget.course.exams!.length,
                                            (index) {
                                              final exam =
                                                  widget.course.exams![index];
                                              return Observer(
                                                builder: (_) => GradeInputRow(
                                                  name: exam.name,
                                                  type: editController
                                                              .gradeTypes[
                                                          exam.name] ??
                                                      'normal',
                                                  controller: editController
                                                          .gradeControllers[
                                                      exam.name],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                        if (widget.course.exams!.isNotEmpty &&
                                            widget.course.assignments!
                                                .isNotEmpty)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            child: Divider(
                                              height: 1,
                                              color: AppColors.gray
                                                  .withValues(alpha: 0.8),
                                            ),
                                          ),
                                        if (widget
                                            .course.assignments!.isNotEmpty) ...[
                                          if (widget.course.exams!.isEmpty)
                                            const SizedBox(height: 16),
                                          const Text(
                                            'TRABALHOS',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.8,
                                              color: AppColors.textFaded,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          ...List.generate(
                                            widget.course.assignments!.length,
                                            (index) {
                                              final assignment = widget
                                                  .course.assignments![index];
                                              return Observer(
                                                builder: (_) => GradeInputRow(
                                                  name: assignment.name,
                                                  type: editController
                                                              .gradeTypes[
                                                          assignment.name] ??
                                                      'normal',
                                                  controller: editController
                                                          .gradeControllers[
                                                      assignment.name],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                        if (!_hasNoGrades) ...[
                                          const SizedBox(height: 12),
                                          Divider(
                                            height: 1,
                                            color: AppColors.gray
                                                .withValues(alpha: 0.8),
                                          ),
                                          const SizedBox(height: 16),
                                          Observer(
                                            builder: (_) {
                                              final scoreValue =
                                                  editController.finalScoreGrade;
                                              final scoreType =
                                                  editController.finalScoreType;
                                              final scoreText = scoreValue == null
                                                  ? '—'
                                                  : scoreValue
                                                      .toStringAsFixed(1)
                                                      .replaceAll('.', ',');
                                              final hasScore =
                                                  scoreValue != null;
                                              return Container(
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(16),
                                                decoration: BoxDecoration(
                                                  color: _mediaBoxColor,
                                                  borderRadius: Round.primary,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'MÉDIA ATUAL',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 0.8,
                                                        color:
                                                            AppColors.textFaded,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: scoreText,
                                                            style: TextStyle(
                                                              fontSize: 28,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: scoreType ==
                                                                      'normal'
                                                                  ? AppColors
                                                                      .black
                                                                  : AppColors
                                                                      .red,
                                                            ),
                                                          ),
                                                          const TextSpan(
                                                            text: ' de 10,0',
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color: AppColors
                                                                  .textFaded,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 6),
                                                    Text(
                                                      hasScore
                                                          ? 'Média calculada com as notas preenchidas.'
                                                          : 'Preencha as notas para calcular sua média.',
                                                      style: const TextStyle(
                                                        fontSize: 13,
                                                        color: AppColors
                                                            .textFaded,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 12,
                                    bottom: 12,
                                    child: Material(
                                      color: AppColors.gray,
                                      shape: const CircleBorder(),
                                      child: InkWell(
                                        customBorder: const CircleBorder(),
                                        onTap: _scrollGradesToBottom,
                                        child: const SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: Icon(
                                            LucideIcons.arrowDown,
                                            color: AppColors.white,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.of(context).size.height - 320,
                              child: const Center(
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: CircularProgressIndicator(
                                    color: AppColors.red,
                                  ),
                                ),
                              ),
                            )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                            onPressed: widget.course.assignments!.isEmpty &&
                                    widget.course.exams!.isEmpty
                                ? () {}
                                : () {
                                    FocusScope.of(context).unfocus();
                                    editController.setFinalScoreCalcError(false);
                                    showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Observer(
                                            builder: (_) => AlertDialog(
                                              content: SizedBox(
                                                height: 250,
                                                child: editController
                                                        .targetCalcInProgress
                                                    ? const Center(
                                                        child: SizedBox(
                                                          height: 50,
                                                          width: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: AppColors.red,
                                                          ),
                                                        ),
                                                      )
                                                    : editController
                                                            .finalScoreCalcError
                                                        ? const Center(
                                                            child: Text(
                                                              "Erro ao calcular a média :(",
                                                              style: TextStyle(
                                                                color:
                                                                    AppColors.red,
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          )
                                                        : Column(
                                                            children: [
                                                              Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceAround,
                                                                  children: [
                                                                    const Text(
                                                                      "Deseja calcular suas notas?",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize: 16),
                                                                    ),
                                                                    RichText(
                                                                      text:
                                                                          const TextSpan(
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.black,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize: 16),
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                "É importante dizer que as notas ",
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                "calculadas por meta ",
                                                                            style: TextStyle(
                                                                                color: AppColors.red,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                "serão contadas como 0 para a média final.",
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ]),
                                                            ],
                                                          ),
                                              ),
                                              actions: [
                                                editController
                                                            .targetCalcInProgress ||
                                                        editController
                                                            .finalScoreCalcError
                                                    ? editController
                                                            .finalScoreCalcError
                                                        ? TextButton(
                                                            style: TextButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                                  AppColors.red,
                                                              foregroundColor:
                                                                  AppColors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      Round.primary),
                                                              minimumSize:
                                                                  const Size
                                                                      .fromHeight(
                                                                      50),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  dialogContext);
                                                              editController
                                                                  .setFinalScoreCalcError(
                                                                      false);
                                                            },
                                                            child: const Text(
                                                                "Fechar"))
                                                        : Container()
                                                    : TextButton(
                                                        style: TextButton.styleFrom(
                                                            backgroundColor:
                                                                AppColors.red,
                                                            foregroundColor:
                                                                AppColors.white,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    Round
                                                                        .primary),
                                                            minimumSize:
                                                                const Size
                                                                    .fromHeight(
                                                                    50),
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 7,
                                                                    horizontal:
                                                                        7)),
                                                        onPressed: () async {
                                                          editController
                                                              .setFinalScoreCalcError(
                                                                  false);
                                                          editController
                                                              .setTargetCalcProgress(
                                                                  true);
                                                          final weights =
                                                              <String,
                                                                  dynamic>{};
                                                          for (var grade
                                                              in widget.course
                                                                      .exams! +
                                                                  widget.course
                                                                      .assignments!) {
                                                            weights[grade.name] =
                                                                grade.weight;
                                                          }
                                                          try {
                                                            final success =
                                                                await editController
                                                                    .calcFinalScore(
                                                              weights,
                                                              editController
                                                                  .grades,
                                                            );
                                                            if (success) {
                                                              final gradesToSave =
                                                                  editController
                                                                      .formatGradesForSaving();
                                                              await gradeController
                                                                  .insertGrades(
                                                                editController
                                                                    .getCourseCode(),
                                                                gradesToSave,
                                                              );
                                                              if (dialogContext
                                                                  .mounted) {
                                                                Navigator.pop(
                                                                    dialogContext);
                                                              }
                                                            }
                                                          } finally {
                                                            editController
                                                                .setTargetCalcProgress(
                                                                    false);
                                                          }
                                                        },
                                                        child: const Text(
                                                            "Confirmar"))
                                              ],
                                            ),
                                          );
                                        });
                                  },
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    widget.course.assignments!.isEmpty &&
                                            widget.course.exams!.isEmpty
                                        ? AppColors.red.withValues(alpha: 0.5)
                                        : AppColors.red,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: Round.primary),
                                minimumSize: const Size.fromHeight(52),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 7)),
                            child: Text(
                                    "Calcular média",
                                    style: TextStyle(
                                        color: widget.course.assignments!
                                                    .isEmpty &&
                                                widget.course.exams!.isEmpty
                                            ? AppColors.white.withValues(alpha: 0.5)
                                            : AppColors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                            ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                            onPressed:
                                widget.course.assignments!.isEmpty &&
                                        widget.course.exams!.isEmpty
                                    ? () {}
                                    : () {
                                        FocusScope.of(context).unfocus();
                                        editController.setTargetCalcError(false);
                                        showDialog(
                                            context: context,
                                            builder: (dialogContext) {
                                              final targetController =
                                                  TextEditingController();
                                              final ValueNotifier<bool>
                                                  isButtonDisabled =
                                                  ValueNotifier<bool>(true);
                                              targetController.addListener(() {
                                                isButtonDisabled.value =
                                                    targetController
                                                        .text.isEmpty;
                                              });
                                              return Observer(
                                                builder: (_) => AlertDialog(
                                                  content: SingleChildScrollView(
                                                    child: SizedBox(
                                                      width: double.maxFinite,
                                                      child: editController
                                                              .targetCalcInProgress
                                                          ? const Padding(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      vertical:
                                                                          24),
                                                              child: Center(
                                                                child: SizedBox(
                                                                  height: 50,
                                                                  width: 50,
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    color: AppColors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : editController
                                                                  .targetCalcError
                                                              ? const Padding(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          vertical:
                                                                              16),
                                                                  child: Text(
                                                                    "Erro ao calcular as notas :(",
                                                                    style:
                                                                        TextStyle(
                                                                      color: AppColors
                                                                          .red,
                                                                      fontSize:
                                                                          16,
                                                                    ),
                                                                  ),
                                                                )
                                                              : Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                      "Como funciona?",
                                                                      style: TextStyle(
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                          fontSize: 16),
                                                                    ),
                                                                    const SizedBox(
                                                                        height: 8),
                                                                    const Text(
                                                                      "1. Digite a nota que você deseja alcançar na matéria.",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize: 16),
                                                                    ),
                                                                    const SizedBox(
                                                                        height: 4),
                                                                    const Text(
                                                                      "2. Calcularemos as notas necessárias para alcançar essa meta.",
                                                                      style: TextStyle(
                                                                          color: AppColors
                                                                              .black,
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          fontSize: 16),
                                                                    ),
                                                                    const SizedBox(
                                                                        height: 4),
                                                                    RichText(
                                                                      text:
                                                                          const TextSpan(
                                                                        style: TextStyle(
                                                                            color: AppColors
                                                                                .black,
                                                                            fontFamily:
                                                                                'Poppins',
                                                                            fontSize: 16),
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                "3. As notas calculadas serão exibidas em ",
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                "vermelho.",
                                                                            style: TextStyle(
                                                                                color: AppColors.red,
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height: 16),
                                                                    GradeInput(
                                                                      changes:
                                                                          false,
                                                                      name:
                                                                          "Sua meta",
                                                                      controller:
                                                                          targetController,
                                                                      labelled:
                                                                          true,
                                                                    ),
                                                                  ],
                                                                ),
                                                    ),
                                                  ),
                                                  actions: [
                                                    editController
                                                            .targetCalcError
                                                        ? TextButton(
                                                            style: TextButton.styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .red,
                                                                foregroundColor:
                                                                    AppColors
                                                                        .white,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        Round
                                                                            .primary),
                                                                minimumSize:
                                                                    const Size
                                                                        .fromHeight(
                                                                        50),
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    vertical: 7,
                                                                    horizontal:
                                                                        7)),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  dialogContext);
                                                              editController
                                                                  .setTargetCalcError(
                                                                      false);
                                                            },
                                                            child: const Text(
                                                                "Fechar"))
                                                        : Container(),
                                                    editController
                                                                .targetCalcInProgress ||
                                                            editController
                                                                .targetCalcError
                                                        ? Container()
                                                        // Verifica se o campo de meta de notas está vazio ou não
                                                        : ValueListenableBuilder<
                                                            bool>(
                                                            valueListenable:
                                                                isButtonDisabled,
                                                            builder: (_,
                                                                    isDisabled,
                                                                    child) =>
                                                                Observer(
                                                              builder: (_) =>
                                                                  TextButton(
                                                                      style: TextButton.styleFrom(
                                                                          backgroundColor: isDisabled
                                                                              ? AppColors.red.withValues(
                                                                                  alpha: 0.5)
                                                                              : AppColors
                                                                                  .red,
                                                                          shape: RoundedRectangleBorder(
                                                                              borderRadius: Round
                                                                                  .primary),
                                                                          minimumSize: const Size
                                                                              .fromHeight(
                                                                              50),
                                                                          padding: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 7,
                                                                              horizontal: 7)),
                                                                      onPressed: isDisabled
                                                                          ? null
                                                                          : () async {
                                                                              editController.setTargetCalcError(false);
                                                                              editController.setTargetCalcProgress(true);
                                                                              editController.setTargetGrade(double.parse(targetController.text));
                                                                              final weights = <String, dynamic>{};
                                                                              for (var grade in widget.course.exams! + widget.course.assignments!) {
                                                                                weights[grade.name] = grade.weight;
                                                                              }

                                                                              try {
                                                                                final success = await editController.calcTargetGrade(editController.grades, weights);
                                                                                if (success) {
                                                                                  final gradesToSave = editController.formatGradesForSaving();
                                                                                  await gradeController.insertGrades(editController.getCourseCode(), gradesToSave);
                                                                                  if (dialogContext.mounted) {
                                                                                    Navigator.pop(dialogContext);
                                                                                  }
                                                                                }
                                                                              } finally {
                                                                                editController.setTargetCalcProgress(false);
                                                                              }
                                                                            },
                                                                      child: Text(
                                                                        "Confirmar",
                                                                        style: TextStyle(
                                                                            color: isDisabled
                                                                                ? AppColors.white.withValues(alpha: 0.5)
                                                                                : AppColors.white),
                                                                      )),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                            style: OutlinedButton.styleFrom(
                                backgroundColor: AppColors.white,
                                foregroundColor: AppColors.black,
                                side: BorderSide(
                                  color: AppColors.gray.withValues(alpha: 0.9),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: Round.primary),
                                minimumSize: const Size.fromHeight(52),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 14, horizontal: 7)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.crosshair,
                                  size: 18,
                                  color: (widget.course.assignments!.isEmpty &&
                                          widget.course.exams!.isEmpty)
                                      ? AppColors.red.withValues(alpha: 0.4)
                                      : AppColors.red,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Definir meta de nota",
                                  style: TextStyle(
                                      color: (widget.course.assignments!.isEmpty &&
                                              widget.course.exams!.isEmpty)
                                          ? AppColors.black.withValues(alpha: 0.4)
                                          : AppColors.black,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future _showErasePopup(BuildContext context, CourseModel course) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const SizedBox(
            height: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Tem certeza?",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.red),
                  ),
                ),
                Text(
                  "Todas as notas vindas da meta de notas serão apagadas.",
                  style: TextStyle(fontSize: 14, color: AppColors.black),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                editController.eraseTargetGrades();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Apagar',
                style: TextStyle(fontSize: 16, color: AppColors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Fechar',
                style: TextStyle(fontSize: 16, color: AppColors.red),
              ),
            ),
          ],
        );
      });
}

Future<void> _openStudyPlanPdf(CourseModel course) async {
  final url = course.studyPlanDownloadPdfUrl;
  if (url == null || url.isEmpty) return;
  final uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> _showExamsCodeInfo(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: const EdgeInsets.fromLTRB(20, 16, 12, 0),
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
        title: const Text(
          'Critério de aprovação',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: AppColors.red,
          ),
        ),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                  child: Text(
                    'O código (ex.: C4/2015) indica a família do critério. '
                    'A estrutura esperada segue a tabela abaixo.',
                    style: TextStyle(fontSize: 13, color: AppColors.textFaded),
                  ),
                ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1.2),
                    1: FlexColumnWidth(1.6),
                  },
                  border: TableBorder(
                    horizontalInside: BorderSide(
                      color: AppColors.gray.withValues(alpha: 0.8),
                    ),
                  ),
                  children: [
                    const TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Text(
                            'Família',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
                          child: Text(
                            'Estrutura',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: AppColors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ...examsCodeReferenceRows.map(
                      (row) => TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            child: Text(
                              row.family,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 8),
                            child: Text(
                              row.structure,
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.textFaded,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 10, 8, 4),
                  child: Text(
                    'Ex.: C4/2015 → trabalhos + 2 provas',
                    style: TextStyle(
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                      color: AppColors.textFaded,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(
              'Fechar',
              style: TextStyle(fontSize: 16, color: AppColors.red),
            ),
          ),
        ],
      );
    },
  );
}

Future<dynamic> _showCourseDefinitions(
    BuildContext context, CourseModel course) {
  final examWeightPct =
      (normalizeCourseComponentWeight(course.examWeight) * 100).round();
  final assignmentWeightPct =
      (normalizeCourseComponentWeight(course.assignmentWeight) * 100).round();

  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Definições da matéria",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: AppColors.red),
                  ),
                ),
                if (course.examsCode != null && course.examsCode!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      "Critério: ${course.examsCode}",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.black),
                    ),
                  ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      const Text(
                        "Plano de Ensino",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: AppColors.black),
                      ),
                      if (hasStudyPlanPdf(course)) ...[
                        const SizedBox(width: 8),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          tooltip: 'Abrir PDF',
                          icon: const Icon(
                            Icons.picture_as_pdf,
                            color: AppColors.red,
                            size: 22,
                          ),
                          onPressed: () => _openStudyPlanPdf(course),
                        ),
                      ],
                    ],
                  ),
                ),
                course.exams!.isEmpty && course.assignments!.isEmpty
                    ? const Text(
                        "Nenhuma nota cadastrada",
                        style: TextStyle(fontSize: 14, color: AppColors.black),
                      )
                    : Container(),
                course.exams!.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Provas: $examWeightPct%",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.black),
                            ),
                            Text(
                              _genWeightsText(course.exams),
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                  color: AppColors.black),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                course.assignments!.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trabalhos: $assignmentWeightPct%",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.black),
                          ),
                          Text(
                            _genWeightsText(course.assignments),
                            style: const TextStyle(
                                fontSize: 14, color: AppColors.black),
                          )
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Fechar',
                style: TextStyle(fontSize: 16, color: AppColors.red),
              ),
            ),
          ],
        );
      });
}

String _genWeightsText(List? activities) {
  String text = "";
  for (var activity in activities!) {
    text += "${activity.name}: ${activity.weight * 100}% ";
  }
  return text;
}
