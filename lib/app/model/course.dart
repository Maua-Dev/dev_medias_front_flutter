class CourseModel {
  final String code;
  final String name;
  final String period;
  final dynamic examWeight;
  final dynamic assignmentWeight;

  final List<dynamic>? exams;
  final List<dynamic>? assignments;

  final dynamic courses;

  /// Critério de aprovação (ex.: C4/2015, B1). Null se o PDF não trouxer.
  final String? examsCode;

  /// URL HTTPS pública (CloudFront) do plano de ensino. Null se indisponível.
  final String? studyPlanDownloadPdfUrl;

  /// Matéria criada pelo usuário (não faz parte do catálogo oficial).
  final bool isCustom;

  /// Device dono da matéria custom. Null no catálogo oficial.
  final String? deviceId;

  final String? createdAt;
  final String? updatedAt;

  CourseModel({
    this.code = "Sem codigo",
    this.name = "Sem Nome",
    this.period = "Sem período",
    this.examWeight = 50.0,
    this.assignmentWeight = 50.0,
    this.exams,
    this.assignments,
    this.courses,
    this.examsCode,
    this.studyPlanDownloadPdfUrl,
    this.isCustom = false,
    this.deviceId,
    this.createdAt,
    this.updatedAt,
  });

  Map<String, Object?> toJson() => {
        "code": code,
        "name": name,
        "period": period,
        "examWeight": examWeight,
        "assignmentWeight": assignmentWeight,
        "exams": exams,
        "assignments": assignments,
        "courses": courses,
        "examsCode": examsCode,
        "studyPlanDownloadPdfUrl": studyPlanDownloadPdfUrl,
        "isCustom": isCustom,
        "deviceId": deviceId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  factory CourseModel.fromJson(Map<String, Object?> json) => CourseModel(
        code: json["code"] as String,
        name: json["name"] as String,
        period: (json["period"] as String?) ?? "Sem período",
        examWeight: json["examWeight"] as dynamic,
        assignmentWeight: json["assignmentWeight"] as dynamic,
        exams: json["exams"] as List<dynamic>?,
        assignments: json["assignments"] as List<dynamic>?,
        courses: json["courses"] as dynamic,
        examsCode: json["examsCode"] as String?,
        studyPlanDownloadPdfUrl: json["studyPlanDownloadPdfUrl"] as String?,
        isCustom: (json["isCustom"] as bool?) ?? false,
        deviceId: json["deviceId"] as String?,
        createdAt: json["createdAt"] as String?,
        updatedAt: json["updatedAt"] as String?,
      );
}
