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
  final bool planActive;
  final CurrentSubscription currentSubscription;

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
    required this.planActive,
    required this.currentSubscription,
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
    planActive: json["plan_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    currentSubscription:
        json["current_subscription"] != null
            ? CurrentSubscription.fromJson(json["current_subscription"])
            : CurrentSubscription(
              id: 0,
              userId: 0,
              planId: 0,
              razorpayPaymentId: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              status: '',
            ),
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
    "plan_active": planActive,
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

class CurrentSubscription {
  final int id;
  final int userId;
  final int planId;
  final String razorpayPaymentId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;

  CurrentSubscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.razorpayPaymentId,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  factory CurrentSubscription.fromJson(Map<String, dynamic> json) =>
      CurrentSubscription(
        id: json["id"],
        userId: json["user_id"],
        planId: json["plan_id"],
        razorpayPaymentId: json["razorpay_payment_id"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "plan_id": planId,
    "razorpay_payment_id": razorpayPaymentId,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "status": status,
  };
}
