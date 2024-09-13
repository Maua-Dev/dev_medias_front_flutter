// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:dev_medias_front_flutter/app/controller/intro_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/user_controller.dart';
import 'package:dev_medias_front_flutter/app/widgets/community_logo.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/widgets/starting_data_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      // await userController.resetUserData();
      final userDataMissing = await userController.checkUserDataExists();
      if (userDataMissing == false) {
        introPageController.setLoginSuccesful(true);
        Navigator.pushNamed(context, '/home');
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
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      child: StartingDataForm(),
                    )
                  )
                )
              )
            );
  }
}
