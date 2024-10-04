import 'package:dev_medias_front_flutter/app/controller/user_controller.dart';
import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/app_colors.dart';
import 'package:dev_medias_front_flutter/app/utils/theme/measurements.dart';
import 'package:flutter/material.dart';

class AddCourseCard extends StatefulWidget {
  final CourseModel course;
  final int index;

  const AddCourseCard({
    super.key,
    required this.index,
    required this.course,
  });

  @override
  State<AddCourseCard> createState() => _AddCourseCardState();
}

class _AddCourseCardState extends State<AddCourseCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(milliseconds: 500), vsync: this);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(-1.5, 0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
  double _height = 72;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateHeight(double height) {
    setState(() {
      _height = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        child: SizedBox(
          height: _height,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: ElevatedButton(
              onPressed: () async {
                _controller.forward();
                await Future.delayed(const Duration(milliseconds: 500));
                _updateHeight(0);
                await Future.delayed(const Duration(milliseconds: 250));
                userController.insertCurrentCourses(widget.course.code);
              },
              style: TextButton.styleFrom(
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(borderRadius: Round.primary),
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 7)),
              child: Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.course.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18, color: AppColors.black),
                          ),
                          FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                widget.course.code,
                                style: const TextStyle(
                                    fontSize: 12, color: AppColors.black),
                              )),
                        ],
                      ),
                    ),
                    Stack(children: [
                      Container(
                        color: AppColors.white,
                        height: 30,
                        width: 30,
                      ),
                      const Icon(
                        Icons.add_box,
                        color: AppColors.red,
                        size: 40,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
