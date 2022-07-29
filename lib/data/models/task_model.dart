import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    required this.revision,
    required this.status,
    required this.list,
  });


  int revision;
  String status;
  List<Task> list;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
    revision: json["revision"],
    status: json["status"],
    list: List<Task>.from(json["list"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "revision": revision,
    "status": status,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class Task {
  Task({
    required this.id,
    required this.createdAt,
    required this.text,
    required this.lastUpdatedBy,
    required this.changedAt,
    required this.deadline,
    this.color,
    required this.done,
    required this.importance,
  });

  String id;
  int createdAt;
  String text;
  String lastUpdatedBy;
  int changedAt;
  int deadline;
  String? color;
  bool done;
  String importance;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    createdAt: json["created_at"],
    text: json["text"],
    lastUpdatedBy: json["last_updated_by"],
    changedAt: json["changed_at"],
    deadline: json["deadline"],
    color: json["color"],
    done: json["done"],
    importance: json["importance"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "text": text,
    "last_updated_by": lastUpdatedBy,
    "changed_at": changedAt,
    "deadline": deadline,
    "color": color,
    "done": done,
    "importance": importance,
  };

  String getShortTask() {
    if (text.length > 30) {
      return '${text.substring(0, 30)}...';
    } else {
      return text;
    }
  }

}

