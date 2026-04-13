import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _tasks = [];

  List<Todo> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();

  List<Todo> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

 
  void addTask(String title) {
    if (title.trim().isEmpty) return;
    _tasks.add(Todo(title: title));
    notifyListeners();
  }

  void toggleTask(Todo task) {
    task.isCompleted = !task.isCompleted;
    notifyListeners();
  }


  void deleteTask(Todo task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void clearCompleted() {
    _tasks.removeWhere((task) => task.isCompleted);
    notifyListeners();
  }


  void deleteAll() {
    _tasks.clear();
    notifyListeners();
  }
}
