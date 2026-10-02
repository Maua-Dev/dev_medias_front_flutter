import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/add_course_card.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/navigation_top_bar.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/app_drawer.dart';
import 'package:dev_medias_front_flutter/app/widgets/search_course_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  void initState() {
    addController.loadCourses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // Ícones brancos
        statusBarBrightness: Brightness.dark, // Para iOS
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.background,
          endDrawer: const AppDrawer(),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Center(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.only(top: 56.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      // Logo DevMédias
                      const NavigationTopBar(
                        prevPage: '/home',
                      ),
                      // Campo de Pesquisar Matérias
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: SearchCourseField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton.icon(
                            onPressed: () async {
                              commonController.setPreviousPage('/add');
                              final created = await Navigator.of(context)
                                  .pushNamed('/create-custom');
                              if (created == true && mounted) {
                                await addController.loadCourses();
                              }
                            },
                            icon: const Icon(Icons.add,
                                size: 18, color: AppColors.white),
                            label: const Text(
                              'Criar matéria personalizada',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.white),
                              shape: RoundedRectangleBorder(
                                  borderRadius: Round.primary),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 10),
                            ),
                          ),
                        ),
                      ),
                      // Lista de Matérias — Expanded evita overflow no loading
                      Expanded(
                        child: Observer(
                          builder: (_) => addController.coursesLoaded
                              ? ScrollConfiguration(
                                  behavior:
                                      ScrollConfiguration.of(context).copyWith(
                                    scrollbars: false,
                                    overscroll: false,
                                    physics: const BouncingScrollPhysics(),
                                  ),
                                  child: RawScrollbar(
                                    child: ListView.builder(
                                      keyboardDismissBehavior:
                                          ScrollViewKeyboardDismissBehavior
                                              .onDrag,
                                      padding: EdgeInsets.zero,
                                      itemCount: addController
                                          .availableCourses?.length,
                                      itemBuilder: (context, index) {
                                        String? key = addController
                                            .availableCourses?.keys
                                            .toList()
                                            .elementAt(index);
                                        CourseModel course = addController
                                            .availableCourses?[key];
                                        return AddCourseCard(
                                          key: UniqueKey(),
                                          index: index,
                                          course: course,
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      color: AppColors.red,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
