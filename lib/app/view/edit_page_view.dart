import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/grade_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditPage extends StatelessWidget {
  final Course course;

  const EditPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    HomePageController controller = HomePageController();
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
                // Logo DevMédias
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 11),
                  child: Image(
                      image: AssetImage(
                          'lib/app/assets/images/dev_medias_logo.png')),
                ),
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
                                course.name ?? "Sem Nome",
                                style: TextStyle(
                                    fontSize: 22, color: AppColors.black),
                              ),
                              Text(
                                course.name ?? "Sem Código",
                                style: TextStyle(
                                    fontSize: 12, color: AppColors.black),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
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
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(255, 255, 255, 1),
                                borderRadius: Round.primary),
                            child: Column(
                              children: [
                                Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                                Text("Provas",
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 16)),
                                Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                                Container(
                                  child: GridView(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(horizontal: 24),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                ),
                                Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                                Text("Trabalhos",
                                    style: TextStyle(
                                        color: AppColors.black, fontSize: 16)),
                                Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                                Container(
                                  child: Center(
                                    child: GridView(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.symmetric(horizontal: 24),
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                                ),
                                Text("Média Final",
                                          style: TextStyle(
                                              color: AppColors.black, fontSize: 16)),
                                GradeInput(labelled: false,),
                                Padding(padding: EdgeInsets.symmetric(vertical: 6)),
                              ],
                            )),
                      )
                    ],
                  ),
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