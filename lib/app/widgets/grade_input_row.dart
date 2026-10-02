import 'package:dev_medias_front_flutter/app/controller/edit_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/grade_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/text_formatters/grade_formatter.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Horizontal grade row used by the edit-page redesign experiment.
class GradeInputRow extends StatelessWidget {
  final String name;
  final String type;
  final TextEditingController? controller;

  const GradeInputRow({
    super.key,
    required this.name,
    this.type = 'normal',
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 64,
            height: 40,
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: type == 'normal' ? AppColors.black : AppColors.red,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onChanged: (String value) {
                if (value.isNotEmpty) {
                  editController.grades[name] = double.parse(value);
                  editController.gradeControllers[name]?.text = value;
                  editController.gradeTypes[name] = 'normal';
                } else {
                  editController.grades[name] = null;
                  editController.gradeControllers[name]?.text = '';
                  editController.gradeTypes[name] = 'normal';
                }
                final grades = editController.formatGradesForSaving();
                gradeController.insertGrades(
                    editController.getCourseCode(), grades);
              },
              inputFormatters: [
                LengthLimitingTextInputFormatter(4),
                GradeInputFormatter(),
              ],
              decoration: InputDecoration(
                hintText: '—',
                hintStyle: const TextStyle(
                  color: AppColors.textFaded,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.zero,
                fillColor: AppColors.white,
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderRadius: Round.secondary,
                  borderSide: BorderSide(
                    color: AppColors.gray.withValues(alpha: 0.9),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: Round.secondary,
                  borderSide: const BorderSide(color: AppColors.red, width: 1.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: Round.secondary,
                  borderSide: BorderSide(
                    color: AppColors.gray.withValues(alpha: 0.9),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
