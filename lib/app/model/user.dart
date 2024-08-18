import 'package:dev_medias_front_flutter/app/database/user_database.dart';

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
        UserFields.nameColumnName: name,
        UserFields.userYearColumnName: year,
        UserFields.userGraduationColumnName: graduation,
      };

  factory UserModel.fromJson(Map<String, Object?> json) => UserModel(
        name: json[UserFields.nameColumnName] as String,
        year: json[UserFields.userYearColumnName] as int,
        graduation: json[UserFields.userGraduationColumnName] as String,
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
