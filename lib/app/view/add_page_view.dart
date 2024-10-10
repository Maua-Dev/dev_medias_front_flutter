import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/widgets/add_course_card.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/navigation_top_bar.dart';
import 'package:dev_medias_front_flutter/app/widgets/search_course_field.dart';
import 'package:flutter/material.dart';
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  // Logo DevMédias
                  const NavigationTopBar(
                    prevPage: '/home',
                  ),
                  // Campo de Pesquisar Matérias
                 const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: SearchCourseField(),
                  ),
                  // Lista de Matérias
                  Observer(
                    builder: (_) => addController.coursesLoaded ?
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Expanded(
                          child: ScrollConfiguration(
                            behavior: ScrollConfiguration.of(context).copyWith(
                              scrollbars: false,
                              overscroll: false,
                              physics: const BouncingScrollPhysics(),
                            ),
                            child: RawScrollbar(
                              child: ListView.builder(
                                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                padding: EdgeInsets.zero,
                                shrinkWrap: true,
                                itemCount: addController.availableCourses?.length,
                                itemBuilder: (context, index) {
                                  String? key =
                                      addController.availableCourses?.keys.toList().elementAt(index);
                                  CourseModel course = addController.availableCourses?[key];
                                  return AddCourseCard(
                                    key: UniqueKey(),
                                    index: index,
                                    course: course,
                                  );
                                  },
                                ),
                            ),
                          ),
                        ),
                      ) : SizedBox(
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
