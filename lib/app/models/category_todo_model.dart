import 'package:flutter/material.dart';

class CategoryTodoModel {
  final String categoryTitle;
  final String categoryNote;
  final userID;
  final categoryID;

  CategoryTodoModel(
      {@required this.categoryTitle,
      this.categoryNote,
      @required this.userID,
      @required this.categoryID});

  factory CategoryTodoModel.fromDocument(Map<String, dynamic> data) {
    return CategoryTodoModel(
      categoryTitle: data['title'],
      categoryNote: data['notes'],
      userID: data['user_id'],
      categoryID: data['category_id'],
    );
  }
}
