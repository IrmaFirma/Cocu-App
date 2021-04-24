import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:working_project/app/models/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  List<TodoModel> _todoModels = <TodoModel>[];
  List<TodoModel> _completedModels = <TodoModel>[];

  List<TodoModel> get todoModels =>
      _todoModels.where((todo) => todo.isCompleted == false).toList();

  List<TodoModel> get completedModels =>
      _completedModels.where((todo) => todo.isCompleted == true).toList();

  //add new todos
  Future<void> addTodo(
      {String description,
      String date,
      @required String categoryID,
      bool isCompleted,
      @required String userID,
      @required String title}) async {
    try {
      Map<String, dynamic> todo = <String, dynamic>{
        'todo_id': '',
        'user_id': userID,
        'category_id': categoryID,
        'title': title,
        'description': description,
        'isCompleted': isCompleted,
        'date': date,
      };
      final DocumentReference documentReference = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .add(todo);
      Map<String, dynamic> fTodo = <String, dynamic>{
        'todo_id': documentReference.id,
        'user_id': userID,
        'title': title,
        'description': description,
        'date': date,
        'isCompleted': isCompleted,
        'category_id': categoryID,
      };
      _todoModels.add(TodoModel.fromDocument(fTodo));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .doc(documentReference.id)
          .update(fTodo);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //display todos
  Future<void> readTodo(
      {@required String userID, @required String categoryID}) async {
    try {
      _todoModels = <TodoModel>[];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .get()
          .then((QuerySnapshot value) {
        // ignore: avoid_function_literals_in_foreach_calls
        value.docs.forEach((QueryDocumentSnapshot snap) {
          if (snap.data()['isCompleted'] == false &&
              snap.data()['user_id'] == userID &&
              snap.data()['category_id'] == categoryID) {
            _todoModels.add(TodoModel.fromDocument(snap.data()));
          }
        });
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> readCompletedTodo(
      {@required String userID, @required String categoryID}) async {
    try {
      _completedModels = <TodoModel>[];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .get()
          .then((QuerySnapshot value) {
        // ignore: avoid_function_literals_in_foreach_calls
        value.docs.forEach((QueryDocumentSnapshot snap) {
          if (snap.data()['isCompleted'] == true &&
              snap.data()['user_id'] == userID &&
              snap.data()['category_id'] == categoryID) {
            _completedModels.add(TodoModel.fromDocument(snap.data()));
          }
        });
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //delete
  Future<void> deleteTodo(
      {@required String userID,
      @required String todoID,
      @required String categoryID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .doc(todoID)
          .delete();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //update todos fields
  Future<void> updateTodo(
      {@required String title,
      @required String description,
      String date,
      @required String categoryID,
      @required String userID,
      @required String todoID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .doc(todoID)
          .update(<String, dynamic>{
        'title': title,
        'description': description,
        'date': date,
        'category_id': categoryID,
        'user_id': userID,
        'todo_id': todoID
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //isCompleted toggle
  Future<void> markAsDone(
      {@required String userID,
      @required String todoID,
      @required String categoryID,
      bool isCompleted}) async {
    try {
      isCompleted = !isCompleted;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .doc(todoID)
          .update(<String, dynamic>{
        'user_id': userID,
        'todo_id': todoID,
        'isCompleted': isCompleted,
        'category_id': categoryID
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
