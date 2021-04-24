import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:working_project/app/models/category_todo_model.dart';

class CategoryTodoProvider extends ChangeNotifier {
  List<CategoryTodoModel> _categoryModels = <CategoryTodoModel>[];

  List<CategoryTodoModel> get categoryModels => _categoryModels;

  //add new todos
  Future<void> addCategory(
      {String notes, @required String userID, @required String title}) async {
    try {
      Map<String, dynamic> category = <String, dynamic>{
        'category_id': '',
        'user_id': userID,
        'title': title,
        'notes': notes,
      };
      final DocumentReference documentReference = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .add(category);
      Map<String, dynamic> fCategory = <String, dynamic>{
        'category_id': documentReference.id,
        'user_id': userID,
        'title': title,
        'notes': notes,
      };
      _categoryModels.add(CategoryTodoModel.fromDocument(fCategory));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(documentReference.id)
          .update(fCategory);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //display todos
  Future<void> readCategory({@required String userID}) async {
    try {
      _categoryModels = <CategoryTodoModel>[];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .get()
          .then((QuerySnapshot value) {
        // ignore: avoid_function_literals_in_foreach_calls
        value.docs.forEach((QueryDocumentSnapshot snap) {
          if (snap.data()['user_id'] == userID) {
            _categoryModels.add(CategoryTodoModel.fromDocument(snap.data()));
          }
        });
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //delete
  Future<void> deleteCategory(
      {@required String userID, @required String categoryID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .delete();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .collection('todo')
          .get()
          .then((value) => {
                for (DocumentSnapshot ds in value.docs)
                  {
                    ds.reference.delete(),
                  }
              });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //update todos fields
  Future<void> updateCategory(
      {@required String title,
      @required String notes,
      @required String userID,
      @required String categoryID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('category')
          .doc(categoryID)
          .update(<String, dynamic>{
        'title': title,
        'notes': notes,
        'user_id': userID,
        'category_id': categoryID
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }
}
