import 'package:flutter/material.dart';

class TodoModel {
  final String todoTitle;
  final String todoDescription;
  final String dueDate;
  final bool isCompleted;
  final userID;
  final todoID;

  TodoModel(
      {@required this.todoTitle,
      this.todoDescription,
      this.isCompleted = false,
      @required this.dueDate,
      @required this.userID,
      @required this.todoID});

  factory TodoModel.fromDocument(Map<String, dynamic> data) {
    return TodoModel(
      todoTitle: data['title'],
      dueDate: data['date'],
      todoDescription: data['description'],
      userID: data['user_id'],
      todoID: data['todo_id'],
      isCompleted: data['isCompleted'],
    );
  }
}
