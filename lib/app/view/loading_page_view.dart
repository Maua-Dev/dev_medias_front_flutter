// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dev_medias_front_flutter/app/controller/common/courses_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/intro_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/loading_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/common/user_controller.dart';
import 'package:dev_medias_front_flutter/app/widgets/community_logo.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      loadingPageController.setLoading(true);
      // await userController.resetUserData();
      final userDataMissing = await userController.checkUserDataExists();
      await coursesController.getCourses();
      await coursesController.getGrads();
      await userController.getCurrentCourses();
      if (userDataMissing == false) {
        introPageController.setLoginSuccesful(true);
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/first');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.background,
        body: Center(
            child: Observer(
                builder: (_) => AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                    child: loadingPageController.getLoading()
                        ? Container()
                        : const CommunityLogo()))));
  }
}
