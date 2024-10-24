import 'package:dev_medias_front_flutter/app/controller/popup_delete_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';

class PopupDeleteCourseWidget extends StatelessWidget {
  final PopupDeleteController controller;

  const PopupDeleteCourseWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        if (controller.isVisible) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            content: SizedBox(
              width: 400,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Título do Popup
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            height: 50,
                            child: const Text(
                              "Excluir Matéria",
                              style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        IconButton(
                          padding: const EdgeInsets.only(left: 20.0),
                          icon: const Icon(
                            Icons.disabled_by_default_rounded,
                            size: 30,
                            color: AppColors.red,
                          ),
                          onPressed: () {
                            //Fecha o popup
                            controller.hidePopup();
                          },
                        ),
                      ],
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        "Você deseja excluir essa matéria? Todas as notas serão perdidas.",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    const Spacer(),

                    // Botões
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            fixedSize: const Size(150, 50),
                          ),
                          onPressed: () {
                            //cancela a exlucão
                            controller.hidePopup();
                          },
                          child: const Text(
                            "Cancelar",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            fixedSize: const Size(150, 50),
                          ),
                          onPressed: () {
                            //função de excluir
                            controller.deleteCourse();
                          },
                          child: const Text(
                            "Excluir",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const SizedBox
              .shrink(); // Retorna um widget vazio se o popup não estiver visível
        }
      },
    );
  }
}
