import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/view/home_page_view.dart';
import 'package:dev_medias_front_flutter/app/widgets/common/return_button.dart';
import 'package:dev_medias_front_flutter/app/widgets/popup_report_error.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class NavigationTopBar extends StatelessWidget {
  final String? prevPage;
  final bool isHomePage;

  const NavigationTopBar({super.key, this.prevPage, this.isHomePage = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Botão de ícone voltar com ação interna
        if (prevPage != null) const ReturnButton(),
        // Botão de ícone menu lateral
        if (isHomePage) const MenuButton(),
        // Botão de ícone Reportar erro
        const SupportButton(),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        LucideIcons.menu,
        size: 30,
        color: AppColors.white,
      ),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
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
        LucideIcons.headphones,
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
