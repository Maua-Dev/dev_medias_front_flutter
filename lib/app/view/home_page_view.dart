import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/added_course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

HomePageController controller = HomePageController();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Center(
          child: FractionallySizedBox(
            widthFactor: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Logo DevMédias
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  child: const Image(
                      image: AssetImage(
                          'lib/app/assets/images/dev_medias_logo.png')),
                ),
                // Botão Adicionar Matérias
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AppColors.white,
                        shape:
                            RoundedRectangleBorder(borderRadius: Round.primary),
                        minimumSize: Size(0, 63),
                        padding: EdgeInsets.symmetric(horizontal: 10)),
                    onPressed: () {
                      Navigator.pushNamed(context, '/add');
                    },
                    child: Row(
                      children: [
                        Opacity(
                            opacity: 0.7,
                            child: const Text(
                              "Adicionar Matéria",
                              style: TextStyle(
                                  fontSize: 20.0, color: AppColors.black),
                            )),
                        Expanded(child: Container()),
                        SvgPicture.asset(
                          'lib/app/assets/icons/add_button.svg',
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                // Lista de Matérias
                Observer(
                  builder: (_) => Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: controller.current_courses.courses.length,
                      itemBuilder: (context, index) {
                        return ClipRRect(
                          borderRadius: Round.primary,
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              controller.removeCourse(index);
                            },
                            background: Container(
                              margin: EdgeInsets.only(bottom: 12),
                              decoration: BoxDecoration(
                                  color: AppColors.red,
                                  borderRadius: Round.primary),
                              child: Align(
                                  alignment: AlignmentDirectional.centerEnd,
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColors.white,
                                  )),
                            ),
                            child: AddedCourseCard(
                              index: index,
                              controller: controller,
                              courseName: controller
                                  .current_courses.courses[index]["name"],
                              courseDesc: controller
                                  .current_courses.courses[index]["desc"],
                              courseGrade: controller
                                  .current_courses.courses[index]["grade"],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Seção de Suporte
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: const SupportBox(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SupportBox extends StatelessWidget {
  const SupportBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: Round.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Precisa de Ajuda?",
                  style: TextStyle(color: AppColors.white, fontSize: 15),
                ),
                Text(
                  "Entre em contato com a Dev",
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ],
            ),
            Expanded(child: Container()),
            ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.purpleButton,
                    shape: RoundedRectangleBorder(borderRadius: Round.primary)),
                onPressed: () {},
                child: Text(
                  "Suporte",
                  style: TextStyle(color: AppColors.white),
                ))
          ],
        ),
      ),
    );
  }
}
