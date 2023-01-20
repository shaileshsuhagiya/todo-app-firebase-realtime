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
    this.id,
  });

  int? categoryType;
  int? createdAt;
  int? updatedAt;
  int? dueDate;
  String? description;
  String? taskTitle;
  String? userId;
  bool isCompleted;
  String? id;

  factory TaskModel.fromJson(docId,Map<String, dynamic> json,) => TaskModel(
    id:docId,
    categoryType: json["categoryType"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    dueDate: json["dueDate"],
    description: json["description"],
    taskTitle: json["taskTitle"],
    isCompleted: json["isCompleted"]?? false,
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