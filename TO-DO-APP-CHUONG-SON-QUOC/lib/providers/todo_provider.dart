import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  String currentDate = DateFormat.yMMMd().format(DateTime.now());
  List<String> categories = ["Khẩn cấp", "Quan trọng", "Bình thường"];

  //test data
  List<Todo> allTodos = [
    Todo(
        title: "Viết ứng dụng",
        date: "20, Tháng 3, 2023",
        time: "8:00 AM",
        description: "Viết hết các widget ứng dụng trước khi kiểm tra.",
        category: "Quan trọng"),
    Todo(
        title: "Kiểm tra app, chạy thử",
        date: "23, Tháng 3, 2023",
        time: "3:00 PM",
        description: "Hoàn thành trước thời gian cho phép",
        category: "Quan trọng"),
    Todo(
        title: "Thi Giữa kỳ, báo cáo môn Lập trình cho thiết bị di động",
        date: "24, Tháng 3, 2023",
        time: "9:30 AM",
        description: "Hoàn thành đưa code lên Github",
        category: "Khẩn cấp"),
  ];

  List<Todo> get deletedTodos {
    return allTodos.where((element) => element.toBeDeleted).toList();
  }

  List<Todo> get completedTodos {
    return allTodos
        .where((element) => element.isComplete && !element.toBeDeleted)
        .toList();
  }

  void addTodo(String title, String description, String date, String time,
      String category) {
    allTodos.add(Todo(
        title: title,
        date: date,
        description: description,
        time: time,
        category: category));
    notifyListeners();
  }

  void toggleToBeDeleted(Todo todo) {
    todo.toBeDeleted = !todo.toBeDeleted;
    notifyListeners();
  }

  void toggleIsComplete(Todo todo) {
    todo.isComplete = !todo.isComplete;
    notifyListeners();
  }

  List<Todo> getSearchResults(String task) {
    return allTodos
        .where((element) =>
            RegExp(task, caseSensitive: false).hasMatch(element.title))
        .toList();
  }

  void addCategory(String category) {
    categories.add(category);
    notifyListeners();
  }

  void removeCategory(String category) {
    categories.remove(category);
    notifyListeners();
  }
}
