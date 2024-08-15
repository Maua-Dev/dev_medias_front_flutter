import 'dart:async';

import 'package:dev_medias_front_flutter/app/controller/intro_page_controller.dart';
import 'package:dev_medias_front_flutter/app/widgets/community_logo.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () async {
      bool dataCheck = false;
      dataCheck = await introPageController.checkUserData();
      if (!dataCheck == true) {
        Navigator.of(context).pushNamed('/home');
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
          child: AnimatedSwitcher(
              duration: Duration(milliseconds: 500), child: CommunityLogo()),
        ));
  }
}
