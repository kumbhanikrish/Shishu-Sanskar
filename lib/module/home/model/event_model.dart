class EventModel {
  final int id;
  final String title;
  final String description;
  final String image;
  final DateTime date;
  final String time;
  final String link;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String formattedDatetime;
  final String imageName;
  bool isLoginUserEventsParticipation;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.time,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.formattedDatetime,
    required this.imageName,
    required this.isLoginUserEventsParticipation,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    date: DateTime.parse(json["date"]),
    time: json["time"],
    link: json["link"],
    isLoginUserEventsParticipation: json["is_login_user_events_participation"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    formattedDatetime: json["formatted_datetime"],
    imageName: json["image_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "date":
        "${date.year.toString().padLeft(4, '0')}/${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}",
    "time": time,
    "link": link,
    "is_login_user_events_participation": isLoginUserEventsParticipation,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "formatted_datetime": formattedDatetime,
    "image_name": imageName,
  };
}
