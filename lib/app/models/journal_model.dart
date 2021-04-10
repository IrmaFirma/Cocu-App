//TODO Add required
import 'package:flutter/material.dart';

class JournalModel {
  final String journalID;
  final String userID;
  final String title;
  final String subtitle;
  final String description;
  final String createdDate;

  JournalModel(
      {@required this.journalID,
      @required this.userID,
      this.createdDate,
      @required this.title,
      this.subtitle,
      this.description});

  factory JournalModel.fromDocument(Map<String, dynamic> data) {
    return JournalModel(
        journalID: data['journal_id'],
        createdDate: data['created_date'],
        userID: data['user_id'],
        title: data['title'],
        subtitle: data['subtitle'],
        description: data['description']);
  }
}
