class TaskModel {
  TaskModel({
    this.categoryType,
    this.createdAt,
    this.updatedAt,
    this.dueDate,
    this.description,
    this.taskTitle,
    this.userId,
    this.isCompleted = false,
  });

  int? categoryType;
  int? createdAt;
  int? updatedAt;
  int? dueDate;
  String? description;
  String? taskTitle;
  String? userId;
  bool isCompleted;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    categoryType: json["categoryType"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    dueDate: json["dueDate"],
    description: json["description"],
    taskTitle: json["taskTitle"],
    isCompleted: json["isCompleted"],
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "categoryType": categoryType,
    "taskTitle": taskTitle,
    "description": description,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "dueDate": dueDate,
    "isCompleted": isCompleted,
    "userId": userId,
  };
}