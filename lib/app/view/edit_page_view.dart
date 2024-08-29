import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
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
    editController.resetGradeControllers();
    final grades = widget.course.exams! + widget.course.assignments!;
    editController.setCourseCode(widget.course.code);
    editController.buildGrades(grades);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 320,
                              child: Text(
                                widget.course.name,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 24, color: AppColors.black),
                              ),
                            ),
                            Text(
                              widget.course.code,
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.black),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: AppColors.red,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              // Menu Matéria
              SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 350,
                  child: Container(
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: Round.primary),
                      child: Column(
                        children: [
                          widget.course.exams!.isEmpty &&
                                  widget.course.assignments!.isEmpty
                              ? const Expanded(
                                  child: Center(
                                      child: Text(
                                          "Essa matéria não tem notas cadastradas.")))
                              : Container(),
                          widget.course.exams!.isNotEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 32, bottom: 16),
                                  child: Text("Provas",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 20)),
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
                                    ),
                                  ),
                                );
                              })),
                          widget.course.assignments!.isNotEmpty
                              ? const Padding(
                                  padding: EdgeInsets.only(top: 32, bottom: 16),
                                  child: Text("Trabalhos",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 20)),
                                )
                              : Container(),
                          Wrap(
                              runSpacing: 4,
                              spacing: 4,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                  widget.course.assignments!.length, (index) {
                                return Observer(
                                  builder: (_) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GradeInput(
                                      name: widget
                                          .course.assignments![index].name,
                                      labelled: true,
                                      controller:
                                          editController.gradeControllers[widget
                                              .course.assignments![index].name],
                                    ),
                                  ),
                                );
                              })),
                          Expanded(child: Container()),
                          const Padding(
                            padding: EdgeInsets.only(top: 32, bottom: 32),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 16.0),
                                  child: Text("Média Final",
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontSize: 20)),
                                ),
                                GradeInput(
                                  labelled: false,
                                  enabled: false,
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
              ),
              // Seção de Suporte
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Map<String, dynamic> weights = {};
                            for (var grade in widget.course.exams! +
                                widget.course.assignments!) {
                              weights[grade.name] = grade.weight;
                            }
                            editController.calcTargetGrade(
                                editController.grades, weights, 6);
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
                                  "Definir meta",
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 22),
                                ),
                              ],
                            ),
                          )),
                    ),
                    Container(
                      width: 12,
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> weights = {};
                            for (var grade in widget.course.exams! +
                                widget.course.assignments!) {
                              weights[grade.name] = grade.weight;
                            }
                            final res = await editController.calcTargetGrade(
                                editController.grades, weights, 0);
                            print(res);
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
                                  "Calcular",
                                  style: TextStyle(
                                      color: AppColors.white, fontSize: 22),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
