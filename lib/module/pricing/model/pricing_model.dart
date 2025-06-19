class PricingModel {
  final int id;
  final int categoryId;
  final String title;
  final String price;
  final String currency;
  final String duration;
  final String type;
  final bool isActive;
  final List<String> services;
  final DateTime createdAt;
  final DateTime updatedAt;

  PricingModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.currency,
    required this.duration,
    required this.type,
    required this.isActive,
    required this.services,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) => PricingModel(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    price: json["price"],
    currency: json["currency"],
    duration: json["duration"],
    type: json["type"],
    isActive: json["is_active"],
    services: List<String>.from(json["services"].map((x) => x)),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "title": title,
    "price": price,
    "currency": currency,
    "duration": duration,
    "type": type,
    "is_active": isActive,
    "services": List<dynamic>.from(services.map((x) => x)),
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
