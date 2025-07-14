class WeeklyReportModel {
  final WeeklyData data;
  final List<WeeklyCompletedTasksList> completedTasksList;

  WeeklyReportModel({required this.data, required this.completedTasksList});

  factory WeeklyReportModel.fromJson(Map<String, dynamic> json) =>
      WeeklyReportModel(
        data: WeeklyData.fromJson(json["data"]),
        completedTasksList:
            json["completed_tasks_list"] == null
                ? []
                : List<WeeklyCompletedTasksList>.from(
                  json["completed_tasks_list"].map(
                    (x) => WeeklyCompletedTasksList.fromJson(x),
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

class WeeklyCompletedTasksList {
  final int id;
  final String name;
  final dynamic photo;
  final String description;
  final int isMain;
  final DateTime createdAt;
  final DateTime updatedAt;

  WeeklyCompletedTasksList({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.isMain,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WeeklyCompletedTasksList.fromJson(Map<String, dynamic> json) =>
      WeeklyCompletedTasksList(
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

class WeeklyData {
  final Day tuesday;
  final Day wednesday;
  final Day thursday;
  final Day friday;
  final Day saturday;
  final Day sunday;
  final Day monday;

  WeeklyData({
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
    required this.monday,
  });

  factory WeeklyData.fromJson(Map<String, dynamic> json) => WeeklyData(
    tuesday:
        json["tuesday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["tuesday"]),
    wednesday:
        json["wednesday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["wednesday"]),
    thursday:
        json["thursday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["thursday"]),
    friday:
        json["friday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["friday"]),
    saturday:
        json["saturday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["saturday"]),
    sunday:
        json["sunday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["sunday"]),
    monday:
        json["monday"] == null
            ? Day(tasks: 0, completedTasks: 0, pendingTasks: 0)
            : Day.fromJson(json["monday"]),
  );

  Map<String, dynamic> toJson() => {
    "tuesday": tuesday.toJson(),
    "wednesday": wednesday.toJson(),
    "thursday": thursday.toJson(),
    "friday": friday.toJson(),
    "saturday": saturday.toJson(),
    "sunday": sunday.toJson(),
  };
}

class Day {
  final int tasks;
  final int completedTasks;
  final int pendingTasks;

  Day({
    required this.tasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    tasks: json["tasks"],
    completedTasks: json["completed_tasks"],
    pendingTasks: json["pending_tasks"],
  );

  Map<String, dynamic> toJson() => {
    "tasks": tasks,
    "completed_tasks": completedTasks,
    "pending_tasks": pendingTasks,
  };
}
