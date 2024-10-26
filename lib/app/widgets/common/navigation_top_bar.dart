import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/return_button.dart';
import 'package:dev_medias_front_flutter/app/widgets/popup_report_error.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:flutter/material.dart';


class NavigationTopBar extends StatelessWidget {
  final String? prevPage;

  const NavigationTopBar({super.key, this.prevPage});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Botão de ícone voltar com ação interna
        ReturnButton(),
        // Logo
        Logo(),
        // Botão de ícone Reportar erro
        SupportButton(),
      ],
    );
  }
}

class SupportButton extends StatelessWidget {
  const SupportButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.headset_mic_rounded,
        size: 30,
        color: AppColors.white,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
         return const PopupReportError();
         },
        );
      },
    );
  }
}
