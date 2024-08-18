class CourseModel {
  final String code;
  final String name;
  final String period;
  final dynamic examWeight;
  final dynamic assignmentWeight;

  final List<dynamic>? exams;
  final List<dynamic>? assignments;

  final dynamic courses;

  CourseModel({
    this.code = "Sem codigo",
    this.name = "Sem Nome",
    this.period = "Sem período",
    this.examWeight = 50.0,
    this.assignmentWeight = 50.0,
    this.exams,
    this.assignments,
    this.courses,
  });

  Map<String, Object?> toJson() => {
        "code": code,
        "name": name,
        "period": period,
        "examWeight": examWeight,
        "assignmentWeight": assignmentWeight,
        "exams": exams,
        "assignments": assignments,
        "courses": courses
      };

  factory CourseModel.fromJson(Map<String, Object?> json) => CourseModel(
      code: json["code"] as String,
      name: json["name"] as String,
      period: json["period"] as String,
      examWeight: json["examWeight"] as dynamic,
      assignmentWeight: json["assignmentWeight"] as dynamic,
      exams: json["exams"] as List<dynamic>? ,
      assignments: json["assignment"] as List<dynamic>? ,
      courses: json["courses"] as dynamic
    );
}
