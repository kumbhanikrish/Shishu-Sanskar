class LoginModel {
  final UserData user;
  final String token;

  LoginModel({required this.user, required this.token});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(user: UserData.fromJson(json["user"]), token: json["token"]);

  Map<String, dynamic> toJson() => {"user": user.toJson(), "token": token};
}

class UserData {
  int id;
  String userUniqueId;
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
  int categoryId;
  int languageId;
  dynamic lmp;
  String googleToken;
  String appleToken;
  String fcmToken;
  int isActive;
  dynamic markedForDeletionAt;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  bool planActive;
  String fullName;
  String categoryName;
  String city;
  String state;
  String country;
  Subscription currentSubscription;
  List<Subscription> subscriptions;

  UserData({
    required this.id,
    required this.firstName,
    required this.userUniqueId,
    required this.middleName,
    required this.lastName,
    required this.languageId,
    required this.categoryName,
    required this.profileImage,
    required this.city,
    required this.state,
    required this.country,
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
    required this.fullName,
    required this.currentSubscription,
    required this.subscriptions,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    userUniqueId: json["user_id"] ?? '',
    firstName: json["first_name"] ?? '',
    middleName: json["middle_name"] ?? '',
    lastName: json["last_name"] ?? '',
    profileImage: json["profile_image"] ?? '',
    email: json["email"] ?? '',
    categoryName: json["category_name"] ?? '',
    gender: json["gender"] ?? '',
    marital: json["marital"] ?? '',
    city: json["city"] ?? '',
    state: json["state"] ?? '',
    country: json["country"] ?? '',
    noOfKid: json["no_of_kid"] ?? 0,
    languageId: json["language_id"] ?? 0,
    contactNumber: json["contact_number"] ?? '',
    whatsappNumber: json["whatsapp_number"] ?? '',
    categoryId: json["category_id"] ?? 0,
    lmp: json["lmp"],
    googleToken: json["google_token"] ?? '',
    appleToken: json["apple_token"] ?? '',
    fcmToken: json["fcm_token"] ?? '',
    isActive: json["is_active"] ?? 0,
    markedForDeletionAt: json["marked_for_deletion_at"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    planActive: json["plan_active"] ?? false,
    fullName: json["full_name"],
    currentSubscription:
        json["current_subscription"] == null
            ? Subscription(
              id: 0,
              userId: 0,
              planId: 0,
              razorpayPaymentId: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              status: '',
              plan: Plan(
                id: 0,
                categoryId: 0,
                title: '',
                price: '',
                currency: '',
                duration: '',
                type: '',
                isActive: false,
                services: [],
              ),
            )
            : Subscription.fromJson(json["current_subscription"]),
    subscriptions:
        json["subscriptions"] == null
            ? []
            : List<Subscription>.from(
              json["subscriptions"].map((x) => Subscription.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userUniqueId,
    "first_name": firstName,
    "middle_name": middleName,
    "last_name": lastName,
    "profile_image": profileImage,
    "email": email,
    "category_name": categoryName,
    "gender": gender,
    "marital": marital,
    "state": state,
    "city": city,
    "country": country,
    "no_of_kid": noOfKid,
    "contact_number": contactNumber,
    "whatsapp_number": whatsappNumber,
    "category_id": categoryId,
    "lmp": lmp,
    "language_id": languageId,
    "google_token": googleToken,
    "apple_token": appleToken,
    "fcm_token": fcmToken,
    "is_active": isActive,
    "marked_for_deletion_at": markedForDeletionAt,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "plan_active": planActive,
    "full_name": fullName,
    "current_subscription": currentSubscription.toJson(),
    "subscriptions": List<dynamic>.from(subscriptions.map((x) => x.toJson())),
  };
}

class Subscription {
  final int id;
  final int userId;
  final int planId;
  final String razorpayPaymentId;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final Plan plan;

  Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.razorpayPaymentId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.plan,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    userId: json["user_id"],
    planId: json["plan_id"],
    razorpayPaymentId: json["razorpay_payment_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    plan: Plan.fromJson(json["plan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "plan_id": planId,
    "razorpay_payment_id": razorpayPaymentId,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "status": status,
    "plan": plan.toJson(),
  };
}

class Plan {
  final int id;
  final int categoryId;
  final String title;
  final String price;
  final String currency;
  final String duration;
  final String type;
  final bool isActive;
  final List<String> services;

  Plan({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.price,
    required this.currency,
    required this.duration,
    required this.type,
    required this.isActive,
    required this.services,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: json["id"],
    categoryId: json["category_id"],
    title: json["title"],
    price: json["price"],
    currency: json["currency"],
    duration: json["duration"],
    type: json["type"],
    isActive: json["is_active"],
    services: List<String>.from(json["services"].map((x) => x)),
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
  };
}
