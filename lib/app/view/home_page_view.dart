// ignore_for_file: avoid_print
import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/notifications_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/widgets/add_course_navigation_button.dart';
import 'package:dev_medias_front_flutter/app/widgets/current_course_card.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/navigation_top_bar.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/app_drawer.dart';
import 'package:dev_medias_front_flutter/app/widgets/notice_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarContrastEnforced: false,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        drawer: const AppDrawer(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                NavigationTopBar(
                  prevPage: commonController.getPreviousPage,
                  isHomePage: true,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: AddCourseNavigationButton(),
                ),
                Expanded(
                  child: Observer(
                      builder: (_) => coursesController.loadedCourses
                          ? userController.currentCourses.isNotEmpty
                              ? ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: userController
                                                .currentCourses.length,
                                            itemBuilder: (context, index) {
                                              final courseCode = userController
                                                  .currentCourses[index];
                                              final CourseModel? course =
                                                  coursesController
                                                      .allCourses?[courseCode];
                                              if (course == null) {
                                                return const SizedBox.shrink();
                                              }
                                              return FutureBuilder<String>(
                                                future: updateFinalScore(
                                                    course.code),
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
                                          )
                              : const Center(
                                  child: Text(
                                    "Você não tem matérias cadastradas",
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.white,
                                    ),
                                    textAlign: TextAlign.center,
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
                            )),
                ),
              ],
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
    } else {
      _scheduleNotificationsDialog();
    }
  }

  void _scheduleNotificationsDialog() {
    if (noticeDismissedThisAppSession) return;

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || noticeDismissedThisAppSession) return;
      await _loadAndShowNotificationsIfAny(context);
    });
  }

  Future<void> _loadAndShowNotificationsIfAny(BuildContext pageContext) async {
    if (noticeDismissedThisAppSession) return;
    final notificationsUrl = dotenv.env['API_NOTIFICATIONS'];
    final notificationsConfigured = notificationsUrl != null &&
        notificationsUrl.trim().isNotEmpty;

    if (notificationsConfigured) {
      await notificationsController.fetchNotifications();
    }

    if (!pageContext.mounted) return;

    // Sem URL no .env: mostra o aviso estático (até você apontar API_NOTIFICATIONS).
    if (!notificationsConfigured) {
      showBlockingNoticeDialog(pageContext);
      return;
    }

    final items = notificationsController.notices;
    if (items.isEmpty) return;
    final title = items.length == 1 ? items.first.title : 'Avisos';
    final description = items.length == 1
        ? items.first.body
        : items
            .map((n) => '${n.title}\n\n${n.body}')
            .join('\n\n────────────\n\n');
    showBlockingNoticeDialog(
      pageContext,
      title: title,
      description: description,
    );
  }

  void _showTermsOfServiceDialog() {
    final pageContext = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text(
            'Termos de Serviço',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Text(
                kDefaultAppNoticeBody.trim(),
                softWrap: true,
                style: const TextStyle(fontSize: 16.5),
              ),
            ),
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
                      final nav = Navigator.of(dialogContext);
                      final prefs = await SharedPreferences.getInstance();
                      if (!mounted) return;
                      await prefs.setBool('hasAcceptedTerms', true);
                      if (!dialogContext.mounted) return;
                      nav.pop();
                      WidgetsBinding.instance.addPostFrameCallback((_) async {
                        if (!mounted) return;
                        await _loadAndShowNotificationsIfAny(pageContext);
                      });
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
