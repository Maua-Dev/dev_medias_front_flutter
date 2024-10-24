class UserModel {
  final String name;
  final int year;
  final String graduation;

  UserModel(
      {
      this.name = "Sem nome",
      this.graduation = "Sem graduação",
      this.year = 0,
      });

  Map<String, Object?> toJson() => {
        "name": name,
        "year": year,
        "graduation": graduation,
      };

  factory UserModel.fromJson(Map<String, Object?> json) => UserModel(
        name: json["name"] as String,
        year: json["year"] as int,
        graduation: json["graduation"] as String,
      );

  UserModel copy({
    required String name,
    required int year,
    required String graduation,
  }) =>
      UserModel(
        name: name,
        year: year,
        graduation: graduation,
      );
}
