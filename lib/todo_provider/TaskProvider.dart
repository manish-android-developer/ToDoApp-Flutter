import 'package:flutter/material.dart';

import '../local_db/DatabaseHelper.dart';
import '../app_screen/main.dart';
import '../model/Task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  TaskProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    tasks = await _dbHelper.getTasks();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    if (title.isNotEmpty) {
      final task = Task(title: title, isComplete: false);
      await _dbHelper.insertTask(task);
      tasks.add(task);
      notifyListeners();
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    task.isComplete = !task.isComplete;
    await _dbHelper.updateTask(task);
    notifyListeners();
  }
}
