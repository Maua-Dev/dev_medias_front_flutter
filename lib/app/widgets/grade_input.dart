import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GradeInput extends StatelessWidget {
  final String name;
  final bool labelled;
  final bool enabled;
  final TextEditingController? controller;

  const GradeInput(
      {super.key,
      this.name = "Sem Nome",
      this.labelled = true,
      this.enabled = true,
      this.controller
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        labelled
            ? Text(
                name,
                style: const TextStyle(fontSize: 16),
              )
            : Container(),
        SizedBox(
          width: 80,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 20),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            enabled: enabled,
            inputFormatters: [
              LengthLimitingTextInputFormatter(4),
              FilteringTextInputFormatter.allow(RegExp(r'^[0-9,.]*$')),
            ],
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                fillColor: AppColors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: Round.secondary,
                  borderSide: const BorderSide(color: AppColors.red, width: 4),
                )),
          ),
        )
      ],
    );
  }
}
