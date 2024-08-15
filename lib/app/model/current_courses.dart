import 'package:dev_medias_front_flutter/app/model/course.dart';
import 'package:mobx/mobx.dart';

class CurrentCourses {
  final List<Course> courses;

  CurrentCourses({required this.courses});
}
