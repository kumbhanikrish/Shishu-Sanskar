class BlogsModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  BlogsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
