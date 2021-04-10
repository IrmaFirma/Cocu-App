import 'package:flutter/material.dart';

//TODO: Due date
class GoalModel {
  final String goalTitle;
  final String userID;
  final String goalID;
  final String date;

  GoalModel({
    @required this.date,
    @required this.goalTitle,
    @required this.userID,
    @required this.goalID,
  });

  factory GoalModel.fromDocument(Map<String, dynamic> data) {
    return GoalModel(
        date: data['date'],
        goalTitle: data['goal_title'],
        goalID: data['goal_id'],
        userID: data['user_id']);
  }
}
