import '../models/task.dart';

List<Task> getPendingTasks(List<Task> tasks) {
  List<Task> pendingTasks;

  for (int i = 0; i < tasks.length; i++) {
    if (tasks[i].status == 1) {
      pendingTasks.add(tasks[i]);
    }
  }
  return pendingTasks;
}

List<Task> getRemainingTask(List<Task> tasks) {
  List<Task> pendingTasks;

  for (int i = 0; i < tasks.length; i++) {
    if (tasks[i].status == 0) {
      pendingTasks.add(tasks[i]);
    }
  }
  return pendingTasks;
}

List<Task> getCompletedTaskas(List<Task> tasks) {
  List<Task> pendingTasks;

  for (int i = 0; i < tasks.length; i++) {
    if (tasks[i].status == 2) {
      pendingTasks.add(tasks[i]);
    }
  }
  return pendingTasks;
}

int getCompletedTasksNumber(List<Task> tasks) {
  int completedTasks = 0;
  for (int i = 0; i < tasks.length; i++) {
    if (tasks[i].status == 2) {
      completedTasks = completedTasks + 1;
    }
  }
  return completedTasks;
}
