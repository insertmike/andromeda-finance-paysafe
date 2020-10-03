import './task.dart';

class Kid {
  String name;
  double balance;
  List<Task> tasks;
  int parentId;

  Kid({this.name, this.balance, this.tasks, this.parentId});

  factory Kid.fromJson(Map<String, dynamic> json) => Kid(
      name: json["name"],
      balance: json["balance"],
      parentId: json["parent_id"],
      tasks: json["tasks"].map<Task>((str) => Task.fromJson(str)).toList());
}
