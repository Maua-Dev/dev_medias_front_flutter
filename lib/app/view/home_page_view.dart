import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/add_course_navigation_button.dart';
import 'package:dev_medias_front_flutter/app/widgets/current_course_card.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/navigation_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    editController.resetGradeControllers();
    super.initState();
  }

  Future<String> updateFinalScore(String courseCode) async {
    return await homeController.getFinalScore(courseCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                //Top Barra de Navegação sem botão de voltar
                NavigationTopBar(
                  prevPage: commonController.getPreviousPage,
                ),
                // Botão Adicionar Matérias
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: AddCourseNavigationButton(),
                ),
                // Lista de Matérias
                Observer(
                  builder: (_) => coursesController.loadedCourses
                      ? userController.currentCourses.isNotEmpty
                          ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    itemCount: userController.currentCourses.length,
                                    itemBuilder: (context, index) {
                                      CourseModel? course =
                                          coursesController.allCourses?[
                                              userController.currentCourses[index]];
                                      return FutureBuilder<String>(
                                        future: updateFinalScore(course!.code),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return const Text('Error');
                                          } else {
                                            String finalScore = snapshot.data ?? 'N.A';
                                            return ClipRRect(
                                              borderRadius: Round.primary,
                                              child: Dismissible(
                                                key: UniqueKey(),
                                                direction: DismissDirection.endToStart,
                                                confirmDismiss: (direction) async {
                                                  return await showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        content: SizedBox(
                                                            height: 128,
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                const Text("Remover matéria?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.red),),
                                                                const SizedBox(height: 8),
                                                                Text(
                                                                    "Remover ${course.name}?",
                                                                    style: const TextStyle(
                                                                        fontSize: 14,),
                                                                ),
                                                                ],
                                                            ),
                                                        ),
                                                        actions: <Widget>[
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    backgroundColor: AppColors.red,
                                                                    foregroundColor: AppColors.white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: Round.primary),
                                                                    minimumSize: const Size.fromHeight(50),
                                                                    padding: const EdgeInsets.symmetric(
                                                                        vertical: 7, horizontal: 7)),
                                                                onPressed: () {
                                                                    Navigator.of(context).pop(true);
                                                                },
                                                                child: const Text("Excluir")
                                                            ),
                                                            TextButton(
                                                                style: TextButton.styleFrom(
                                                                    foregroundColor: AppColors.red,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius: Round.primary),
                                                                    minimumSize: const Size.fromHeight(50),
                                                                    padding: const EdgeInsets.symmetric(
                                                                        vertical: 7, horizontal: 7)),
                                                                onPressed: () {
                                                                    Navigator.of(context).pop(false);
                                                                },
                                                                child: const Text("Cancelar")
                                                            )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                onDismissed: (direction) {
                                                  userController
                                                      .removeCurrentCourse(course.code);
                                                },
                                                background: Container(
                                                  margin:
                                                      const EdgeInsets.only(bottom: 12),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.red,
                                                      borderRadius: Round.primary),
                                                  child: Row(
                                                    children: [
                                                      Expanded(child: Container()),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(right: 12),
                                                        child: Icon(
                                                          Icons.delete,
                                                          color: AppColors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                child: CurrentCourseCard(
                                                  key: UniqueKey(),
                                                  index: index,
                                                  finalScore: finalScore,
                                                  course: course,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: const Column(
                                children: [
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Você não tem matérias cadastradas :(",
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: AppColors.textFaded),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            )
                      : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: double.maxFinite,
                            child: const Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
