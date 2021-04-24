import 'package:flutter/material.dart';

class TodoModel {
  final String todoTitle;
  final String todoDescription;
  final String dueDate;
  final bool isCompleted;
  final String userID;
  final String todoID;
  final String currentCategoryID;

  TodoModel(
      {@required this.todoTitle,
      this.todoDescription,
      this.isCompleted = false,
      @required this.currentCategoryID,
      @required this.dueDate,
      @required this.userID,
      @required this.todoID});

  factory TodoModel.fromDocument(Map<String, dynamic> data) {
    return TodoModel(
      todoTitle: data['title'],
      currentCategoryID: data['category_id'],
      dueDate: data['date'],
      todoDescription: data['description'],
      userID: data['user_id'],
      todoID: data['todo_id'],
      isCompleted: data['isCompleted'],
    );
  }
}
