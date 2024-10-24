import 'package:dev_medias_front_flutter/app/controller/common/common_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class CurrentCourseCard extends StatelessWidget {
  final int index;
  final String finalScore;
  final CourseModel course;

  // TO-DO adicionar tratamento de atributos null
  const CurrentCourseCard({
    super.key,
    required this.index,
    required this.finalScore,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit', arguments: {'course': course});
        commonController.setPreviousPage("/home");
      },
      child: ClipRRect(
        borderRadius: Round.primary,
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: Round.primary),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: Round.secondary, color: AppColors.red),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      minWidth: 28,
                      minHeight: 20,
                    ),
                  child: Center(
                    child: Text(
                      finalScore == 'null' ? "N.A" : finalScore,
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                          SizedBox(
                            width: 320,
                            child: Text(
                              course.name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 18, color: AppColors.black),
                            ),
                          ),
                      FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            course.code,
                            style: const TextStyle(fontSize: 12),
                          )),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
