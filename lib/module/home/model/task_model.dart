class TaskModel {
  List<Today> today;
  List<Today> weekly;
  List<Today> daily;

  TaskModel({required this.today, required this.weekly, required this.daily});

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    today: List<Today>.from(json["today"].map((x) => Today.fromJson(x))),
    weekly:
        json["weekly"] == null
            ? []
            : List<Today>.from(json["weekly"].map((x) => Today.fromJson(x))),
    daily:
        json["daily"] == null
            ? []
            : List<Today>.from(json["daily"].map((x) => Today.fromJson(x))),
  );
}

class Today {
  final int id;
  final String category;
  final String? image;
  final List<TodayTask> tasks;

  Today({
    required this.id,
    required this.category,
    required this.image,
    required this.tasks,
  });

  factory Today.fromJson(Map<String, dynamic> json) => Today(
    id: json["id"],
    category: json["category"],
    image: json["image"],
    tasks: List<TodayTask>.from(
      json["tasks"].map((x) => TodayTask.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "image": image,
    "tasks": List<dynamic>.from(tasks.map((x) => x.toJson())),
  };
}

class TodayTask {
  final int id;
  final String title;
  final dynamic description;
  final String status;
  final String type;

  TodayTask({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.type,
  });

  factory TodayTask.fromJson(Map<String, dynamic> json) => TodayTask(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    status: json["status"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "status": status,
    "type": type,
  };
}
