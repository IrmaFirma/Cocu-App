import 'package:flutter/material.dart';

class GoalModel {
  final String goalTitle;
  final String userID;
  final String goalID;
  final String dueDate;

  GoalModel({
    @required this.dueDate,
    @required this.goalTitle,
    @required this.userID,
    @required this.goalID,
  });

  factory GoalModel.fromDocument(Map<String, dynamic> data) {
    return GoalModel(
        dueDate: data['date'],
        goalTitle: data['goal_title'],
        goalID: data['goal_id'],
        userID: data['user_id']);
  }
}
