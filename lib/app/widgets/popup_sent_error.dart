import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';

class PopupErrorSent extends StatelessWidget {
  const PopupErrorSent({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          content: SizedBox(
            width: 300,
            height: 240,
            child: Column(
              children: [
                // Título do popup
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    height: 50,
                    child: const Text(
                      "Erro Enviado",
                      style: TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Mensagem do popup
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "O erro foi enviado e logo será avaliado!\nAgradecemos sua ajuda.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black,
                    ),
                  ),
                ),
                const Spacer(),

                // Botão Concluir
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    fixedSize: const Size(150, 50),
                  ),
                  onPressed: () {
                    // Fecha ambos os popups e retorna à página anterior
                    Navigator.of(context).pop;
                  },
                  child: const Text(
                    "Concluir",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
