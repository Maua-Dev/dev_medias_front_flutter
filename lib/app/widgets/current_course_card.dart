import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class CurrentCourseCard extends StatelessWidget {
  final int index;
  final CourseModel course;

  // TO-DO adicionar tratamento de atributos null
  const CurrentCourseCard({
    super.key,
    required this.index,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/edit', arguments: {'course': course});
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
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      course.code,
                      style:
                          const TextStyle(fontSize: 18, color: AppColors.white),
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
                          course.name,
                          style: const TextStyle(fontSize: 20),
                        )),
                    FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          course.code,
                          style: const TextStyle(fontSize: 12),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
