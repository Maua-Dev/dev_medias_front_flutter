import 'package:dev_medias_front_flutter/app/controller/add_page_controller.dart';
import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class AddCourseCard extends StatelessWidget {
  final Course course;
  final int index;

  const AddCourseCard({
    super.key,
    required this.index,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          addController.addCurrentCourse(course);
        },
        style: TextButton.styleFrom(
            backgroundColor: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: Round.primary),
            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 7)),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      course.name!,
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.black),
                    )),
                FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      course.desc!,
                      style:
                          const TextStyle(fontSize: 12, color: AppColors.black),
                    )),
              ],
            ),
            Expanded(child: Container()),
            const Icon(
              Icons.add_box,
              color: AppColors.red,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
