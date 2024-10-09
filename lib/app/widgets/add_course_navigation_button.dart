import 'package:dev_medias_front_flutter/app/animations/transitions/horizontal_push.dart';
import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:dev_medias_front_flutter/app/view/add_page_view.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:flutter/material.dart';

class AddCourseNavigationButton extends StatelessWidget {
  const AddCourseNavigationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: TextButton.styleFrom(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: Round.primary),
          minimumSize: const Size(0, 63),
          padding: const EdgeInsets.symmetric(horizontal: 10)),
      onPressed: () {
        commonController.setPreviousPage("/home");
        Navigator.of(context).push(HorizontalPush(
            exitPage: const HomePage(),
            enterPage: const AddPage(),
            routeName: "/add"));
      },
      child: Row(
        children: [
          const Opacity(
              opacity: 0.7,
              child: Text(
                "Adicionar Matéria",
                style: TextStyle(fontSize: 20.0, color: AppColors.black),
              )),
          Expanded(child: Container()),
          const Icon(Icons.add_box, size: 50, color: AppColors.red),
        ],
      ),
    );
  }
}
