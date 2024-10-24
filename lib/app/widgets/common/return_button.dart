import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ReturnButton extends StatelessWidget {

  const ReturnButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? prevPage = commonController.getPreviousPage;
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_rounded,
        size: 30,
        // Muda cor se tiver uma página anterior especificada
        color: prevPage != null ? AppColors.white : Colors.transparent,
      ),
      onPressed: prevPage != null ? () {
        // Navegar para a tela anterior se tiver uma página anterior especificada no CommonController
          String? pageToPush = prevPage;
          Navigator.pushNamed(context, pageToPush);
          commonController.setPreviousPage(null);
      } : null,
    );
  }
}
