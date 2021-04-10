import 'package:flutter/material.dart';

class HabitModel {
  final String habitTitle;
  final String habitNote;
  final String habitImportance;
  final String userID;
  final String habitID;
  final String currentGoalID;

  HabitModel(
      {@required this.habitTitle,
      @required this.currentGoalID,
      this.habitNote,
      this.habitImportance,
      @required this.userID,
      @required this.habitID});

  factory HabitModel.fromDocument(Map<String, dynamic> data) {
    return HabitModel(
        habitTitle: data['habitTitle'],
        habitNote: data['habitNote'],
        habitImportance: data['habitImportance'],
        habitID: data['habitID'],
        userID: data['userID'],
        currentGoalID: data['goalID']);
  }
}
