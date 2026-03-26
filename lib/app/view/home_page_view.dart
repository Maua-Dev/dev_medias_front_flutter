// ignore_for_file: avoid_print
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
import 'package:dev_medias_front_flutter/app/widgets/common/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    editController.resetGradeControllers();
    _checkTermsOfService();
    super.initState();
  }

  Future<String> updateFinalScore(String courseCode) async {
    final result = await homeController.getFinalScore(courseCode);
    return result;
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
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 1,
              child: Padding(
                padding: const EdgeInsets.only(top: 56.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Top Barra de Navegação sem botão de voltar
                    NavigationTopBar(
                      prevPage: commonController.getPreviousPage,
                      isHomePage: true,
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
                                    height: MediaQuery.of(context).size.height *
                                            0.7 -
                                        13,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: userController
                                                .currentCourses.length,
                                            itemBuilder: (context, index) {
                                              CourseModel? course =
                                                  coursesController.allCourses?[
                                                      userController
                                                              .currentCourses[
                                                          index]];
                                              return FutureBuilder<String>(
                                                future: updateFinalScore(
                                                    course!.code),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return const CircularProgressIndicator();
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return const Text('Error');
                                                  } else {
                                                    String finalScore =
                                                        snapshot.data ?? 'N.A';
                                                    return ClipRRect(
                                                      borderRadius:
                                                          Round.primary,
                                                      child: IntrinsicHeight(
                                                        // <- Isso força o Stack a medir baseado no conteúdo mais alto
                                                        child: Stack(
                                                          children: [
                                                            // Background do delete (vermelho)
                                                            Positioned.fill(
                                                              child: Container(
                                                                margin:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        bottom:
                                                                            12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      AppColors
                                                                          .red,
                                                                  borderRadius:
                                                                      Round
                                                                          .primary,
                                                                ),
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            20),
                                                                child:
                                                                    const Icon(
                                                                  Icons.delete,
                                                                  color:
                                                                      AppColors
                                                                          .white,
                                                                ),
                                                              ),
                                                            ),
                                                            // Conteúdo principal (card)
                                                            Dismissible(
                                                              key: UniqueKey(),
                                                              direction:
                                                                  DismissDirection
                                                                      .endToStart,
                                                              confirmDismiss:
                                                                  (direction) async {
                                                                return await showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AlertDialog(
                                                                      content:
                                                                          SizedBox(
                                                                        height:
                                                                            128,
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            const Text(
                                                                              "Remover matéria?",
                                                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.red),
                                                                            ),
                                                                            const SizedBox(height: 8),
                                                                            Text(
                                                                              "Remover ${course.name}?",
                                                                              style: const TextStyle(
                                                                                fontSize: 14,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      actions: <Widget>[
                                                                        TextButton(
                                                                          style: TextButton.styleFrom(
                                                                              backgroundColor: AppColors.red,
                                                                              foregroundColor: AppColors.white,
                                                                              shape: RoundedRectangleBorder(borderRadius: Round.primary),
                                                                              minimumSize: const Size.fromHeight(50),
                                                                              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop(true);
                                                                          },
                                                                          child:
                                                                              const Text("Excluir"),
                                                                        ),
                                                                        TextButton(
                                                                          style: TextButton.styleFrom(
                                                                              foregroundColor: AppColors.red,
                                                                              shape: RoundedRectangleBorder(borderRadius: Round.primary),
                                                                              minimumSize: const Size.fromHeight(50),
                                                                              padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7)),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop(false);
                                                                          },
                                                                          child:
                                                                              const Text("Cancelar"),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                              onDismissed:
                                                                  (direction) {
                                                                userController
                                                                    .removeCurrentCourse(
                                                                        course
                                                                            .code);
                                                              },
                                                              background:
                                                                  Container(
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              child:
                                                                  CurrentCourseCard(
                                                                key:
                                                                    UniqueKey(),
                                                                index: index,
                                                                finalScore:
                                                                    finalScore,
                                                                course: course,
                                                              ),
                                                            ),
                                                          ],
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
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                child: Text(
                                                  "Você não tem matérias cadastradas",
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: AppColors.white),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
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
                              )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _checkTermsOfService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool hasAcceptedTerms = prefs.getBool('hasAcceptedTerms') ?? false;

    if (!hasAcceptedTerms) {
      _showTermsOfServiceDialog();
    }
  }

  void _showTermsOfServiceDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Termos de Serviço',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: const Text(
            'A Dev Community Mauá se isenta da responsabilidade de qualquer prejuízo causado por qualquer erro ou imprecisão no cálculo das médias.',
            softWrap: true,
            overflow: TextOverflow.clip,
            style: TextStyle(fontSize: 16.5),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      fixedSize: const Size(150, 50),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('hasAcceptedTerms', true);
                      if (context.mounted) Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Aceitar",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
