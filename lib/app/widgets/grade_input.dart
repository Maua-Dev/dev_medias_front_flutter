import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/text_formatters/grade_formatter.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class GradeInput extends StatelessWidget {
  final String name;
  final String type;
  final bool labelled;
  final bool enabled;
  final bool changes;
  final TextEditingController? controller;

  const GradeInput(
      {super.key,
      this.name = "Sem Nome",
      this.type = "normal",
      this.labelled = true,
      this.changes = true,
      this.enabled = true,
      this.controller});

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
          child: Observer(
            builder: (_) => TextField(
              controller: controller,
              style: TextStyle(fontSize: 20, color: type == "normal" ? AppColors.black : AppColors.red),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              enabled: enabled,
              onChanged: (String value) {
                if (changes && value != "") {
                    editController.grades[name] = double.parse(value);
                    editController.gradeControllers[name]?.text = value;
                    editController.gradeTypes[name] = "normal";
                }
                final grades = editController.formatGradesForSaving();
                gradeController.insertGrades(editController.getCourseCode(), grades);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                GradeInputFormatter(),
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
          ),
        )
      ],
    );
  }
}
