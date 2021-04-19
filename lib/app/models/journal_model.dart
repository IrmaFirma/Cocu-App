import 'package:flutter/material.dart';

class JournalModel {
  final String journalID;
  final String userID;
  final String journalTitle;
  final String journalSubtitle;
  final String journalDescription;
  final String createdDate;

  JournalModel(
      {@required this.journalID,
      @required this.userID,
      this.createdDate,
      @required this.journalTitle,
      this.journalSubtitle,
      this.journalDescription});

  factory JournalModel.fromDocument(Map<String, dynamic> data) {
    return JournalModel(
        journalID: data['journal_id'],
        createdDate: data['created_date'],
        userID: data['user_id'],
        journalTitle: data['title'],
        journalSubtitle: data['subtitle'],
        journalDescription: data['description']);
  }
}
