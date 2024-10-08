import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/grade_input.dart';
import 'package:flutter/material.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class EditPage extends StatefulWidget {
  final CourseModel course;

  const EditPage({super.key, required this.course});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
    initializeAsync();
    super.initState();
  }

  Future<void> initializeAsync() async {
      editController.resetGradeControllers();
      final grades = widget.course.exams! + widget.course.assignments!;
      editController.setCourseCode(widget.course.code);
      editController.buildGrades(grades);
      final savedGrades = await gradeController.getGrades(widget.course.code);
      if (savedGrades != null) {
        editController.renderGrades(savedGrades);
      } else {
        editController.setRendered(true);
      }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo DevMédias
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 11),
                  child: Image(
                      image: AssetImage(
                          'lib/app/assets/images/dev_medias_logo.png')),
                ),
                // Cabeçalho Matéria
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: Round.primary,
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.course.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20, color: AppColors.black),
                                  ),
                                  Text(
                                    widget.course.code,
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColors.black),
                                  ),
                                ],
                              ),
                          ),
                        //   IconButton(
                        //       onPressed: () {
                        //               showDialog(
                        //                         context: context,
                        //                         builder: (BuildContext context) {
                        //                           return AlertDialog(
                        //                             content: SizedBox(
                        //                                 height: 128,
                        //                                 child: Column(
                        //                                     crossAxisAlignment: CrossAxisAlignment.start,
                        //                                     children: [
                        //                                     const Text("Remover matéria?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.red),),
                        //                                     const SizedBox(height: 8),
                        //                                     Text(
                        //                                         "Remover ${widget.course.name}?",
                        //                                         style: const TextStyle(
                        //                                             fontSize: 14,),
                        //                                     ),
                        //                                     ],
                        //                                 ),
                        //                             ),
                        //                             actions: <Widget>[
                        //                                 TextButton(
                        //                                     style: TextButton.styleFrom(
                        //                                         backgroundColor: AppColors.red,
                        //                                         foregroundColor: AppColors.white,
                        //                                         shape: RoundedRectangleBorder(
                        //                                             borderRadius: Round.primary),
                        //                                         minimumSize: const Size.fromHeight(50),
                        //                                         padding: const EdgeInsets.symmetric(
                        //                                             vertical: 7, horizontal: 7)),
                        //                                     onPressed: () {
                        //                                         Navigator.of(context).pop();
                        //                                         userController.removeCurrentCourse(widget.course.code);
                        //                                         Navigator.pushNamed(context, '/home');
                        //                                     },
                        //                                     child: const Text("Excluir")
                        //                                 ),
                        //                                 TextButton(
                        //                                     style: TextButton.styleFrom(
                        //                                         foregroundColor: AppColors.red,
                        //                                         shape: RoundedRectangleBorder(
                        //                                             borderRadius: Round.primary),
                        //                                         minimumSize: const Size.fromHeight(50),
                        //                                         padding: const EdgeInsets.symmetric(
                        //                                             vertical: 7, horizontal: 7)),
                        //                                     onPressed: () {
                        //                                         Navigator.of(context).pop(false);
                        //                                     },
                        //                                     child: const Text("Cancelar")
                        //                                 )
                        //                             ],
                        //                           );
                        //                         },
                        //                       );
                        //       },
                        //       icon: const Icon(
                        //         Icons.delete,
                        //         color: AppColors.red,
                        //         size: 30,
                        //     ))
                        ],
                      ),
                    ),
                  ),
                ),
                // Menu Matéria
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 350,
                    child: Observer(
                      builder: (_) => Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: Round.primary),
                          // Ternário necessário para carregar as cores das notas
                          child: editController.gradeRendered
                          ? Column(
                            children: [
                              widget.course.exams!.isEmpty &&
                                      widget.course.assignments!.isEmpty
                                  ? Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      children: [
                                          Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                  IconButton(
                                                          icon: const Icon(
                                                          Icons.import_contacts,
                                                          color: AppColors.red,
                                                          size: 30,
                                                      ),
                                                      onPressed: () {
                                                            _showCourseDefinitions(context, widget.course);
                                                      },
                                                  ),
                                                  IconButton(
                                                      icon: const Icon(
                                                            Icons.remove,
                                                            color: AppColors.gray,
                                                            size: 30,
                                                       ),
                                                       onPressed: () {

                                                       },
                                                  ),
                                              ],
                                          ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 32),
                                            child: Center(
                                                child: Text(
                                                    "Essa matéria não tem notas cadastradas."
                                                    )
                                                ),
                                        ),
                                      ],
                                    ),
                                  )
                                  : Container(),
                              widget.course.exams!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                            IconButton(
                                                icon: const Icon(
                                                    Icons.import_contacts,
                                                    color: AppColors.red,
                                                    size: 30,
                                                ),
                                                onPressed: () {
                                                    _showCourseDefinitions(context, widget.course);
                                                },
                                            ),
                                            const Text("Provas",
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 20
                                                  )
                                              ),
                                            IconButton(
                                                icon: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.red,
                                                    size: 30,
                                                ),
                                                onPressed: () {

                                                },
                                            ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Wrap(
                                  runSpacing: 4,
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                      widget.course.exams!.length, (index) {
                                    return Observer(
                                      builder: (_) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GradeInput(
                                          name: widget.course.exams![index].name,
                                          labelled: true,
                                          type: editController.gradeTypes[widget.course.exams![index].name]!,
                                          controller: editController.gradeControllers[widget
                                                  .course.exams![index].name],
                                        ),
                                      ),
                                    );
                                  }
                                )
                              ),
                              widget.course.assignments!.isNotEmpty
                                  ? Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                        widget.course.exams!.isEmpty ?
                                          IconButton(
                                                icon: const Icon(
                                                    Icons.import_contacts,
                                                    color: AppColors.red,
                                                    size: 30,
                                                ),
                                                onPressed: () {
                                                    _showCourseDefinitions(context, widget.course);
                                                },
                                           ) : Container(),
                                          const Text("Trabalhos",
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 20)),
                                        widget.course.exams!.isEmpty ?
                                        IconButton(
                                                icon: const Icon(
                                                    Icons.remove,
                                                    color: AppColors.red,
                                                    size: 30,
                                                ),
                                                onPressed: () {

                                                },
                                           ) : Container(),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Wrap(
                                  runSpacing: 4,
                                  spacing: 4,
                                  alignment: WrapAlignment.center,
                                  children: List.generate(
                                      widget.course.assignments!.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GradeInput(
                                        name: widget
                                            .course.assignments![index].name,
                                        labelled: true,
                                        type: editController.gradeTypes[widget.course.assignments![index].name]!,
                                        controller:
                                            editController.gradeControllers[widget
                                                .course.assignments![index].name],
                                      ),
                                    );
                                  })),
                              Expanded(child: Container()),
                              Padding(
                                padding: const EdgeInsets.only(top: 32, bottom: 32),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 16.0),
                                      child: Text("Média Final",
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 20)),
                                    ),
                                    GradeInput(
                                      labelled: false,
                                      controller: editController.finalScoreController,
                                      type: editController.finalScoreType,
                                      enabled: false,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                          : const SizedBox(
                            width: double.maxFinite,
                            child: Center(
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: CircularProgressIndicator(
                                    color: AppColors.red,
                                  ),
                              ),
                            ),
                          )
                        ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    final targetController =
                                        TextEditingController();
                                    final ValueNotifier<bool> isButtonDisabled = ValueNotifier<bool>(true);
                                    targetController.addListener(
                                      () {
                                        isButtonDisabled.value = targetController.text.isEmpty;
                                      }
                                    );
                                    return Observer(
                                      builder: (_) => AlertDialog(
                                        content: SizedBox(
                                          height: 275,
                                          child: editController.targetCalcInProgress
                                          ? const Center(
                                            child: SizedBox(
                                              height: 50,
                                              width: 50,
                                              child: CircularProgressIndicator(
                                                color: AppColors.red,
                                              ),
                                            ),
                                          )
                                          :  editController.targetCalcError ?
                                          const Center(child: Text("Erro ao calcular as notas :(", style: TextStyle(color: AppColors.red, fontSize: 16),)) : Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children:
                                                  [
                                                    const Text("Como funciona?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                                    const Text("1. Digite a nota que você deseja alcançar na matéria.", style: TextStyle(color: AppColors.black, fontFamily: 'Poppins', fontSize: 16),),
                                                    const Text("2. Calcularemos as notas necessárias para alcançar essa meta.", style: TextStyle(color: AppColors.black, fontFamily: 'Poppins', fontSize: 16),),
                                                    RichText(
                                                      text: const TextSpan(
                                                      style: TextStyle(color: AppColors.black, fontFamily: 'Poppins', fontSize: 16),
                                                        children: [
                                                          TextSpan(
                                                            text: "3. As notas calculadas serão exibidas em ",
                                                          ),
                                                          TextSpan(
                                                            text: "vermelho.",
                                                            style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                    ,]
                                                ),
                                              Expanded(child: Container()),
                                              GradeInput(
                                                changes: false,
                                                name: "Sua meta",
                                                controller: targetController,
                                                labelled: true,
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          editController.targetCalcError ? TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: AppColors.red,
                                              foregroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: Round.primary),
                                              minimumSize: const Size.fromHeight(50),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 7, horizontal: 7)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              editController.setTargetCalcError(false);
                                              },
                                            child: const Text("Fechar")) : Container(),
                                          editController.targetCalcInProgress || editController.targetCalcError
                                          ? Container()
                                          // Verifica se o campo de meta de notas está vazio ou não
                                          : ValueListenableBuilder<bool>(
                                              valueListenable: isButtonDisabled,
                                              builder: (context, isDisabled, child) =>
                                              Observer(
                                                builder: (_) => TextButton(
                                                  style: TextButton.styleFrom(
                                                    backgroundColor: isDisabled ? AppColors.gray : AppColors.red,
                                                    foregroundColor: AppColors.white,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: Round.primary),
                                                    minimumSize: const Size.fromHeight(50),
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 7, horizontal: 7)),
                                                    onPressed: isDisabled ? null : () async {
                                                      editController.setTargetCalcProgress(true);
                                                      editController.setTargetGrade(
                                                          double.parse(
                                                              targetController.text));
                                                      Map<String, dynamic> weights = {};
                                                      for (var grade in widget
                                                              .course.exams! +
                                                          widget.course.assignments!) {
                                                        weights[grade.name] =
                                                            grade.weight;
                                                      }
                                                      await editController
                                                          .calcTargetGrade(
                                                              editController.grades,
                                                              weights);
                                                      final gradesToSave = editController.formatGradesForSaving();
                                                      gradeController.insertGrades(editController.getCourseCode(), gradesToSave);
                                                      editController.setTargetCalcProgress(false);
                                                      if (editController.targetCalcError == false) {
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text("Confirmar")),
                                              ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                );
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: Round.primary),
                                minimumSize: const Size.fromHeight(50),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 7)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                "Definir meta",
                                style: TextStyle(
                                    color: AppColors.white, fontSize: 18),
                              ),
                            )),
                      ),
                      Container(
                        width: 12,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Observer(
                                      builder: (_) => AlertDialog(
                                        content: SizedBox(
                                          height: 250,
                                          child:
                                           Column(
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children:
                                                  [
                                                    const Text("Deseja calcular suas notas?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                                    RichText(
                                                      text: const TextSpan(
                                                      style: TextStyle(color: AppColors.black, fontFamily: 'Poppins', fontSize: 16),
                                                        children: [
                                                          TextSpan(
                                                            text: "É importante dizer que as notas ",
                                                          ),
                                                          TextSpan(
                                                            text: "calculadas por meta ",
                                                            style: TextStyle(color: AppColors.red, fontWeight: FontWeight.bold),
                                                          ),
                                                          TextSpan(
                                                            text: "serão contadas como 0 para a média final.",
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ,]
                                                ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          editController.targetCalcInProgress
                                          ? Container()
                                          : TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor: AppColors.red,
                                              foregroundColor: AppColors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: Round.primary),
                                              minimumSize: const Size.fromHeight(50),
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 7, horizontal: 7)),
                                              onPressed: () async {
                                                Map<String, dynamic> weights = {};
                                                for (var grade in widget.course.exams! +
                                                    widget.course.assignments!) {
                                                  weights[grade.name] = grade.weight;
                                                }
                                                editController.calcFinalScore(weights);
                                                final gradesToSave = editController.formatGradesForSaving();
                                                gradeController.insertGrades(editController.getCourseCode(), gradesToSave);
                                              },
                                              child: const Text("Confirmar"))
                                        ],
                                      ),
                                    );
                                  }
                                );
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: Round.primary),
                                minimumSize: const Size.fromHeight(50),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 7)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Calcular média",
                                    style: TextStyle(
                                        color: AppColors.white, fontSize: 18),
                                  ),
                                ],
                              ),
                            )
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

  Future<dynamic> _showCourseDefinitions(context, CourseModel course) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
                height: 160,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom:8),
                          child: Text(
                              "Definições da matéria",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppColors.red),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                              "Plano de Ensino",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.black),
                          ),
                        ),
                        course.exams!.isEmpty && course.assignments!.isEmpty ?
                        const Text(
                             "Nenhuma nota cadastrada",
                          style: TextStyle(
                             fontSize: 14,
                             color: AppColors.black),
                        ) : Container(),
                        course.exams!.isNotEmpty ?
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Text(
                                      "Provas: ${course.examWeight}%",
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
                        ) : Container(),
                        course.assignments!.isNotEmpty ?
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                                Text(
                                    "Trabalhos: ${course.assignmentWeight}%",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: AppColors.black),
                                ),
                                Text(
                                    _genWeightsText(course.assignments),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: AppColors.black),
                                )
                            ],
                        ) : Container(),

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
                    style: TextStyle(
                            fontSize: 16,
                            color: AppColors.red),
                ),
              ),
            ],
          );
        }
    );
  }

  String _genWeightsText(List? activities) {
    String text = "";
    for (var activity in activities!) {
      text += "${activity.name}: ${activity.weight * 100}% ";
    }
    return text;
  }
}
