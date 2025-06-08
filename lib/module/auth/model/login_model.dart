class LoginModel {
  final User user;
  final String token;

  LoginModel({required this.user, required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(user: User.fromJson(json["user"]), token: json["token"]);

  Map<String, dynamic> toJson() => {"user": user.toJson(), "token": token};
}

class User {
  final int id;
  String firstName;
  String middleName;
  String lastName;
  String profileImage;
  String email;
  String gender;
  String marital;
  int noOfKid;
  String contactNumber;
  dynamic whatsappNumber;
  final int categoryId;
  final DateTime lmp;
  final dynamic googleToken;
  final dynamic appleToken;
  final String fcmToken;
  final int isActive;
  final dynamic markedForDeletionAt;
  final dynamic emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.profileImage,
    required this.email,
    required this.gender,
    required this.marital,
    required this.noOfKid,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.categoryId,
    required this.lmp,
    required this.googleToken,
    required this.appleToken,
    required this.fcmToken,
    required this.isActive,
    required this.markedForDeletionAt,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"] ?? '',
    middleName: json["middle_name"] ?? '',
    lastName: json["last_name"] ?? '',
    profileImage: json["profile_image"] ?? '',
    email: json["email"] ?? '',
    gender: json["gender"] ?? '',
    marital: json["marital"] ?? '',
    noOfKid: json["no_of_kid"] ?? 0,
    contactNumber: json["contact_number"] ?? '',
    whatsappNumber: json["whatsapp_number"] ?? '',
    categoryId: json["category_id"],
    lmp: json["lmp"] == null ? DateTime.now() : DateTime.parse(json["lmp"]),
    googleToken: json["google_token"] ?? '',
    appleToken: json["apple_token"] ?? '',
    fcmToken: json["fcm_token"] ?? '',
    isActive: json["is_active"] ?? 0,
    markedForDeletionAt: json["marked_for_deletion_at"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "profile_image": profileImage,
    "email": email,
    "gender": gender,
    "marital": marital,
    "no_of_kid": noOfKid,
    "contact_number": contactNumber,
    "whatsapp_number": whatsappNumber,
    "category_id": categoryId,
    "lmp":
        "${lmp.year.toString().padLeft(4, '0')}-${lmp.month.toString().padLeft(2, '0')}-${lmp.day.toString().padLeft(2, '0')}",
    "google_token": googleToken,
    "apple_token": appleToken,
    "fcm_token": fcmToken,
    "is_active": isActive,
    "marked_for_deletion_at": markedForDeletionAt,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
