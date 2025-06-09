class AuthCategoryModel {
  final int id;
  final String name;
  final dynamic photo;
  final String description;
  final int isMain;
  final DateTime createdAt;
  final DateTime updatedAt;

  AuthCategoryModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.isMain,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AuthCategoryModel.fromJson(Map<String, dynamic> json) =>
      AuthCategoryModel(
        id: json["id"],
        name: json["name"],
        photo: json["photo"] ?? '',
        description: json["description"],
        isMain: json["is_main"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "description": description,
    "is_main": isMain,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
