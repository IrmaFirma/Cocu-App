import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:working_project/app/models/goal_model.dart';

class GoalProvider extends ChangeNotifier {
  List<GoalModel> _goalModels = <GoalModel>[]; //empty list of goal model
  List<GoalModel> get goalModels => _goalModels;

  // add new goal
  Future<void> addGoal({
    @required String userID,
    @required String title,
    @required String date,
  }) async {
    try {
      Map<String, dynamic> goal = <String, dynamic>{
        'goal_id': '',
        'user_id': userID,
        'date': date,
        'goal_title': title,
      };
      final DocumentReference documentReference = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .add(goal);
      Map<String, dynamic> fGoal = <String, dynamic>{
        'goal_id': documentReference.id,
        'user_id': userID,
        'goal_title': title,
        'date': date,
      };
      _goalModels.add(GoalModel.fromDocument(fGoal)); //adding to GoalModel list
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(
            documentReference.id,
          )
          .update(fGoal);
      //update collection and model with new document
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //delete goal with current goalID
  Future<void> deleteGoal(
      {@required String userID, @required String goalID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .delete();
      FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .collection('habits')
          .get()
          .then((value) => {
                for (DocumentSnapshot ds in value.docs)
                  {
                    ds.reference.delete(),
                  }
              });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //update goal
  Future<void> updateGoal({
    @required String title,
    @required String goalID,
    @required String userID,
    @required String date,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .update(<String, dynamic>{
        'goal_title': title,
        'goal_id': goalID,
        'user_id': userID,
        'date': date
      });
      notifyListeners(); // notify listeners for update
    } catch (e) {
      print(e.toString());
    }
  }

  //displaying all documents in goals collection of that user
  Future<void> readGoal({@required String userID}) async {
    try {
      _goalModels = <GoalModel>[];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .get()
          .then((QuerySnapshot value) {
        value.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
          _goalModels.add(GoalModel.fromDocument(documentSnapshot.data()));
        });
      });
      notifyListeners(); // notify listeners to show
    } catch (e) {
      print(e.toString());
    }
  }
}
