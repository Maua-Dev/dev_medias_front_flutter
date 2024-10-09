import 'package:dev_medias_front_flutter/app/controller/popup_delete_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/grade_input.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:dev_medias_front_flutter/app/widgets/navigation_top_bar.dart';
import 'package:dev_medias_front_flutter/app/widgets/popup_delete_course.dart';
import 'package:flutter/material.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';

class EditPage extends StatelessWidget {
  final CourseModel course;
  final PopupDeleteController deleteContoller = PopupDeleteController();

  EditPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Top Barra de Navegação
                const NavigationTopBar(),
                // Cabeçalho Matéria
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: Round.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.name,
                                style: const TextStyle(
                                    fontSize: 22, color: AppColors.black),
                              ),
                              Text(
                                course.name,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.black),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(
                              onPressed: () {
                                deleteContoller.showPopup();
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PopupDeleteCourseWidget(
                                        controller: deleteContoller);
                                  },
                                );
                              },
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
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 1),
                              borderRadius: Round.primary),
                          child: Column(
                            children: [
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                              const Text("Provas",
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 16)),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                              GridView(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisExtent: 55,
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 2,
                                ),
                                children: const [
                                  GradeInput(name: "P1"),
                                  GradeInput(name: "P2"),
                                  GradeInput(name: "PSUB1"),
                                  GradeInput(name: "P3"),
                                  GradeInput(name: "P4"),
                                  GradeInput(name: "PSUB2"),
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                              const Text("Trabalhos",
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 16)),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                              Center(
                                child: GridView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 55,
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 0,
                                    crossAxisSpacing: 2,
                                  ),
                                  children: const [
                                    GradeInput(name: "T1"),
                                    GradeInput(name: "T2"),
                                    GradeInput(name: "T3"),
                                    GradeInput(name: "T4"),
                                  ],
                                ),
                              ),
                              const Text("Média Final",
                                  style: TextStyle(
                                      color: AppColors.black, fontSize: 16)),
                              const GradeInput(
                                labelled: false,
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6)),
                            ],
                          )),
                    )
                  ],
                ),
                Expanded(child: Container()),
                // Seção de Suporte
              ],
            ),
          ),
        ),
      ),
    );
  }
}
