class GradeModel {
  final String name;
  final double weight;

  GradeModel({this.name = "Sem Nome", this.weight = 0.0});

  Map<String, Object?> toJson() => {"name": name, "weight": weight};

  factory GradeModel.fromJson(Map<String, Object?> json) => GradeModel(
      name: json["name"] as String, weight: json["weight"] as double);
}
