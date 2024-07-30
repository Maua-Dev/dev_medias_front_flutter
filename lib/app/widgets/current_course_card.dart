import 'dart:ffi';

import 'package:dev_medias_front_flutter/app/controller/home_page_controller.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class CurrentCourseCard extends StatelessWidget {
  final String? courseName;
  final String? courseDesc;
  final String? courseGrade;
  final String courseId;
  final int index;

  const CurrentCourseCard(
      {super.key,
      required this.index,
      required this.courseId,
      this.courseName = "Sem Nome",
      this.courseDesc = "Sem Descrição",
      this.courseGrade = "NA"});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: Round.primary,
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        decoration:
            BoxDecoration(
              color: AppColors.white, 
              borderRadius: Round.primary),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: Round.secondary, color: AppColors.red),
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                                courseGrade!,
                                style: TextStyle(fontSize: 18, color: AppColors.white),
                              ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        courseName!,
                        style: TextStyle(fontSize: 20),
                      )),
                  FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        courseDesc!,
                        style: TextStyle(fontSize: 12),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
