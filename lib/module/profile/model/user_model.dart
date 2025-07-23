class UserDataModel {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;
  final dynamic profileImage;
  final String email;
  final String gender;
  final String marital;
  final int noOfKid;
  final String contactNumber;
  final String whatsappNumber;
  final int categoryId;
  final dynamic lmp;
  final String googleToken;
  final dynamic appleToken;
  final String fcmToken;
  final int isActive;
  final dynamic markedForDeletionAt;
  final dynamic emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool planActive;
  final List<UserEvent> userEvents;
  final String fullName;
  final Category category;
  final List<Subscription> subscriptions;
  final Subscription currentSubscription;
  final Devices devices;

  UserDataModel({
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
    required this.userEvents,
    required this.fullName,
    required this.category,
    required this.subscriptions,
    required this.currentSubscription,
    required this.devices,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
    id: json["id"],
    firstName: json["first_name"],
    middleName: json["middle_name"] ?? '',
    lastName: json["last_name"],
    profileImage: json["profile_image"],
    email: json["email"],
    gender: json["gender"],
    marital: json["marital"],
    noOfKid: json["no_of_kid"],
    contactNumber: json["contact_number"],
    whatsappNumber: json["whatsapp_number"] ?? '',
    categoryId: json["category_id"],
    lmp: json["lmp"],
    googleToken: json["google_token"] ?? '',
    appleToken: json["apple_token"] ?? '',
    fcmToken: json["fcm_token"],
    isActive: json["is_active"],
    markedForDeletionAt: json["marked_for_deletion_at"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    planActive: json["plan_active"],
    userEvents: List<UserEvent>.from(
      json["user_events"].map((x) => UserEvent.fromJson(x)),
    ),
    fullName: json["full_name"],
    category: Category.fromJson(json["category"]),
    subscriptions:
        json["subscriptions"] == null
            ? []
            : List<Subscription>.from(
              json["subscriptions"].map((x) => Subscription.fromJson(x)),
            ),
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
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            )
            : Subscription.fromJson(json["current_subscription"]),
    devices:
        json["devices"] == null
            ? Devices(
              id: 0,
              userId: 0,
              deviceName: '',
              deviceOs: '',
              appVersion: '',
            )
            : Devices.fromJson(json["devices"]),
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
    "lmp": lmp,
    "google_token": googleToken,
    "apple_token": appleToken,
    "fcm_token": fcmToken,
    "is_active": isActive,
    "marked_for_deletion_at": markedForDeletionAt,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "plan_active": planActive,
    "user_events": List<dynamic>.from(userEvents.map((x) => x.toJson())),
    "full_name": fullName,
    "category": category.toJson(),
    "subscriptions": List<dynamic>.from(subscriptions.map((x) => x.toJson())),
    "current_subscription": currentSubscription.toJson(),
    "devices": devices.toJson(),
  };
}

class Category {
  final int id;
  final String name;
  final dynamic photo;
  final String description;
  final int isMain;

  Category({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.isMain,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    photo: json["photo"],
    description: json["description"],
    isMain: json["is_main"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "photo": photo,
    "description": description,
    "is_main": isMain,
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
  final DateTime createdAt;
  final DateTime updatedAt;
  final Plan? plan;

  Subscription({
    required this.id,
    required this.userId,
    required this.planId,
    required this.razorpayPaymentId,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.plan,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
    id: json["id"],
    userId: json["user_id"],
    planId: json["plan_id"],
    razorpayPaymentId: json["razorpay_payment_id"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    plan: json["plan"] == null ? null : Plan.fromJson(json["plan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "plan_id": planId,
    "razorpay_payment_id": razorpayPaymentId,
    "start_date": startDate.toIso8601String(),
    "end_date": endDate.toIso8601String(),
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "plan": plan?.toJson(),
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
  final DateTime createdAt;
  final DateTime updatedAt;

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
    required this.createdAt,
    required this.updatedAt,
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

class Devices {
  final int id;
  final int userId;
  final String deviceName;
  final String deviceOs;
  final String appVersion;

  Devices({
    required this.id,
    required this.userId,
    required this.deviceName,
    required this.deviceOs,
    required this.appVersion,
  });

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
    id: json["id"],
    userId: json["user_id"],
    deviceName: json["device_name"],
    deviceOs: json["device_os"],
    appVersion: json["app_version"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "device_name": deviceName,
    "device_os": deviceOs,
    "app_version": appVersion,
  };
}

class UserEvent {
  final int id;
  final String title;
  final DateTime date;
  final String time;
  final dynamic location;
  final String description;
  final String image;
  final String formattedDatetime;

  UserEvent({
    required this.id,
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
    required this.image,
    required this.formattedDatetime,
  });

  factory UserEvent.fromJson(Map<String, dynamic> json) => UserEvent(
    id: json["id"],
    title: json["title"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    location: json["location"],
    description: json["description"],
    image: json["image"],
    formattedDatetime: json["formatted_datetime"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date":
        "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "location": location,
    "description": description,
    "image": image,
    "formatted_datetime": formattedDatetime,
  };
}
