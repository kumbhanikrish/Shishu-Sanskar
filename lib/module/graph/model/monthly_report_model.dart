class MonthlyReportModel {
  final Map<String, MonthlyDataModel> data;
  final List<MonthlyCompletedTasksList> completedTasksList;

  MonthlyReportModel({required this.data, required this.completedTasksList});

  factory MonthlyReportModel.fromJson(Map<String, dynamic> json) =>
      MonthlyReportModel(
        data: Map.from(json["data"]).map(
          (k, v) => MapEntry<String, MonthlyDataModel>(
            k,
            MonthlyDataModel.fromJson(v),
          ),
        ),
        completedTasksList:
            json["completed_tasks_list"] == null
                ? []
                : List<MonthlyCompletedTasksList>.from(
                  json["completed_tasks_list"].map(
                    (x) => MonthlyCompletedTasksList.fromJson(x),
                  ),
                ),
      );

  Map<String, dynamic> toJson() => {
    "data": Map.from(
      data,
    ).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
    "completed_tasks_list": List<dynamic>.from(
      completedTasksList.map((x) => x.toJson()),
    ),
  };
}

class MonthlyCompletedTasksList {
  final int id;
  final String name;
  final dynamic photo;
  final String description;
  final int isMain;
  final DateTime createdAt;
  final DateTime updatedAt;

  MonthlyCompletedTasksList({
    required this.id,
    required this.name,
    required this.photo,
    required this.description,
    required this.isMain,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MonthlyCompletedTasksList.fromJson(Map<String, dynamic> json) =>
      MonthlyCompletedTasksList(
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

class MonthlyDataModel {
  final int tasks;
  final int completedTasks;
  final int pendingTasks;

  MonthlyDataModel({
    required this.tasks,
    required this.completedTasks,
    required this.pendingTasks,
  });

  factory MonthlyDataModel.fromJson(Map<String, dynamic> json) =>
      MonthlyDataModel(
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
