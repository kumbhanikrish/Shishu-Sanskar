class LanguagesModel {
  final int id;
  final String name;
  final String code;

  LanguagesModel({required this.id, required this.name, required this.code});

  factory LanguagesModel.fromJson(Map<String, dynamic> json) =>
      LanguagesModel(id: json["id"], name: json["name"], code: json["code"]);

  Map<String, dynamic> toJson() => {"id": id, "name": name, "code": code};
}
