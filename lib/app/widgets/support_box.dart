import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class SupportBox extends StatelessWidget {
  const SupportBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: Round.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Row(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Precisa de Ajuda?",
                  style: TextStyle(color: AppColors.white, fontSize: 15),
                ),
                Text(
                  "Entre em contato com a Dev",
                  style: TextStyle(color: AppColors.white, fontSize: 10),
                ),
              ],
            ),
            Expanded(child: Container()),
            ElevatedButton(
                style: TextButton.styleFrom(
                    backgroundColor: AppColors.purpleButton,
                    shape: RoundedRectangleBorder(borderRadius: Round.primary)),
                onPressed: () {},
                child: const Text(
                  "Suporte",
                  style: TextStyle(color: AppColors.white),
                ))
          ],
        ),
      ),
    );
  }
}
