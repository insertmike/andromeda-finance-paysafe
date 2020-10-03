class Task {
  String summary;
  int status;
  double reward;
  String comment;

  Task({this.summary, this.status, this.reward, this.comment});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      summary: json["summary"],
      status: json["status"],
      reward: json["reward"],
      comment: json["comment"]);
}
