import './task.dart';

class Kid {
  int id;
  String name;
  double balance;
  List<Task> tasks;
  int parentId;

  Kid({this.id, this.name, this.balance, this.tasks, this.parentId});

  factory Kid.fromJson(Map<String, dynamic> json) => Kid(
      id: json["id"],
      name: json["name"],
      balance: json["balance"],
      parentId: json["parent_id"],
      tasks: json["tasks"].map<Task>((str) => Task.fromJson(str)).toList());
}
