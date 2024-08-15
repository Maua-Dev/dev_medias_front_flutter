import 'package:dev_medias_front_flutter/app/model/grade.dart';

class Course {
  final String id;
  final String name;
  final String period;
  final double examWeight;
  final double assignmentWeight;

  final List<Grade> exams;
  final List<Grade> assignments;

  final String desc;
  final String grade;

  Course(
      {
      required this.id,
      this.name = "Sem Nome",
      this.period = "Sem período",
      this.examWeight = 50.0,
      this.assignmentWeight = 50.0,
      this.exams = const [],
      this.assignments = const [],
      this.desc = "Sem descrição",
      this.grade = "NA"
      });
}
