import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class SearchCourseField extends StatelessWidget {
  const SearchCourseField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => TextField(
        onChanged: (value) => {
          addController.setSearchTerm(value),
          addController.searchAvailableCourses()
          },
        onSubmitted: (value) => {
          addController.setSearchTerm(value),
          addController.searchAvailableCourses()
        },
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: InputDecoration(
            hintText: "Buscar Matéria",
            fillColor: AppColors.white,
            filled: true,
            suffixIcon: const Icon(Icons.search, size: 40),
            suffixIconColor: AppColors.red,
            border: OutlineInputBorder(
              borderRadius: Round.primary,
              borderSide: BorderSide.none,
            )),
      ),
    );
  }
}
