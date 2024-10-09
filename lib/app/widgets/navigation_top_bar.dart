import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/widgets/popup_report_error.dart';
import 'package:dev_medias_front_flutter/app/widgets/logo.dart';
import 'package:flutter/material.dart';


class NavigationTopBar extends StatelessWidget {
  const NavigationTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Botão de ícone voltar com ação interna
        Padding(
          padding: const EdgeInsets.only(top: 42, bottom: 18, right: 50.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
              size: 40,
              color: AppColors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Voltar para a tela anterior
            },
          ),
        ),
        Expanded(child: Container()),

        // Logo
        const Padding(
          padding:  EdgeInsets.only(top: 42, bottom: 18),
          child: Logo()
          ),
        Expanded(child: Container()),

        // Botão de ícone Reportar erro
        Padding(
          padding: const EdgeInsets.only(top: 42, bottom: 18, left: 50),
          child: IconButton(
            icon: const Icon(
              Icons.headset_mic_rounded,
              size: 40,
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
          ),
        ),
      ],
    );
  }
}
