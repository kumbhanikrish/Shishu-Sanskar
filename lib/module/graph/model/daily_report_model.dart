// To parse this JSON data, do

class DailyReportModel {
  final DailyData data;
  final List<DailyCompletedTasksList> completedTasksList;

  DailyReportModel({required this.data, required this.completedTasksList});

  factory DailyReportModel.fromJson(Map<String, dynamic> json) =>
      DailyReportModel(
        data: DailyData.fromJson(json["data"]),
        completedTasksList: List<DailyCompletedTasksList>.from(
          json["completed_tasks_list"].map(
            (x) => DailyCompletedTasksList.fromJson(x),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "completed_tasks_list": List<dynamic>.from(
      completedTasksList.map((x) => x.toJson()),
    ),
  };
}

class DailyCompletedTasksList {
  final int id;
  final String name;
  final dynamic photo;
  final String description;
  final int isMain;
  final DateTime createdAt;
  final DateTime updatedAt;

  DailyCompletedTasksList({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.isMain,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DailyCompletedTasksList.fromJson(Map<String, dynamic> json) =>
      DailyCompletedTasksList(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
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

class DailyData {
  final int tasks;
  final int completedTasks;
  final int pendingTasks;
  final int currentSubscriptionDay;

  DailyData({
    required this.tasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.currentSubscriptionDay,
  });

  factory DailyData.fromJson(Map<String, dynamic> json) => DailyData(
    tasks: json["tasks"],
    completedTasks: json["completed_tasks"],
    pendingTasks: json["pending_tasks"],
    currentSubscriptionDay: json["current_subscription_day"],
  );

  Map<String, dynamic> toJson() => {
    "tasks": tasks,
    "completed_tasks": completedTasks,
    "pending_tasks": pendingTasks,
    "current_subscription_day": currentSubscriptionDay,
  };
}

class DailyDateModel {
  final int index;
  final String date; // format: dd-MM-yyyy
  final String dayName; // format: EEE (Mon, Tue...)

  DailyDateModel({
    required this.index,
    required this.date,
    required this.dayName,
  });
}
