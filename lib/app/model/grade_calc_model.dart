class GradesModel {
  final Map<String, Map> notas;
  final double? mediaFinal;

  GradeCalcModel({
    this.provasQueTenho = const [],
    this.trabalhosQueTenho = const [],
    this.provasQueQuero = const [],
    this.trabalhosQueQuero = const [],
    this.mediaDesejada,
  });

  Map<String, Object?> toJson() => {
        "provas_que_tenho": provasQueTenho,
        "trabalhos_que_tenho": trabalhosQueTenho,
        "provas_que_quero": provasQueQuero,
        "trabalhos_que_quero": trabalhosQueQuero,
        "media_desejada": mediaDesejada
      };

  factory GradeCalcModel.fromJson(Map<String, Object?> json) =>
      GradeCalcModel(
        provasQueTenho: json["provas_que_tenho"] as List<Map<String, double>>,
        trabalhosQueTenho: json["trabalhos_que_tenho"] as List<Map<String, double>>,
        provasQueQuero: json["provas_que_quero"] as List<Map<String, double>>,
        trabalhosQueQuero: json["trabalhos_que_quero"] as List<Map<String, double>>,
        mediaDesejada: json["media_desejada"] as double,
      );
}
