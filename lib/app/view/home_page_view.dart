import 'package:dev_medias_front_flutter/app/controller/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/add_course_navigation_button.dart';
import 'package:dev_medias_front_flutter/app/widgets/current_course_card.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:dev_medias_front_flutter/app/widgets/navigation_top_bar.dart';
import 'package:dev_medias_front_flutter/app/widgets/support_box.dart';
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
                //Top Barra de Navegação sem botão de voltar
                const NavigationTopBar(),
                // Botão Adicionar Matérias
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: AddCourseNavigationButton(),
                ),
                // Lista de Matérias
                Observer(
                  builder: (_) => coursesController.loadedCourses
                      ? userController.currentCourses.isNotEmpty
                          ? Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: userController.currentCourses.length,
                                itemBuilder: (context, index) {
                                  CourseModel? course =
                                      coursesController.allCourses?[
                                          userController.currentCourses[index]];
                                  return ClipRRect(
                                    borderRadius: Round.primary,
                                    child: Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.endToStart,
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
                                        index: index,
                                        course: course!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : const Expanded(
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
                            )
                      : const Expanded(
                          child: Center(child: Text('Carregando...'))),
                ),
                // Seção de Suporte
                const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: SupportBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
