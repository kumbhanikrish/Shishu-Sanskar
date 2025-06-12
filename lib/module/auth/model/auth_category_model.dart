import 'package:animated_custom_dropdown/custom_dropdown.dart';

class AuthCategoryModel with CustomDropdownListFilter {
  final int id;
  final String name;
  final dynamic photo;
  final String description;
  final int isMain;

  AuthCategoryModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.isMain,
  });

  factory AuthCategoryModel.fromJson(Map<String, dynamic> json) =>
      AuthCategoryModel(
        id: json["id"],
        name: json["name"],
        photo: json["photo"] ?? '',
        description: json["description"],
        isMain: json["is_main"],
      );

  @override
  String toString() {
    return name;
  }

  @override
  bool filter(String query) {
    return name.toLowerCase().contains(query.toLowerCase());
  }
}
