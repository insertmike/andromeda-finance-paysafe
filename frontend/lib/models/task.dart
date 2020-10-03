class Task {
  int kidId;
  String summary;
  int status;
  double reward;
  String comment;

  Task({this.summary, this.kidId, this.status, this.reward, this.comment});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      kidId: json["child_id"],
      summary: json["summary"],
      status: json["status"],
      reward: json["reward"],
      comment: json["comment"]);
}
