import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:working_project/app/models/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  List<HabitModel> _habitModels = <HabitModel>[];

  List<HabitModel> get habitModels => _habitModels;

  //add new habit
  Future<void> addHabit(
      {@required String userID,
      @required String goalID,
      @required String title,
      String note,
      String importance}) async {
    try {
      Map<String, dynamic> habit = <String, dynamic>{
        'habitID': '',
        'userID': userID,
        'habitNote': note,
        'habitImportance': importance,
        'goalID': goalID,
        'habitTitle': title
      };
      final DocumentReference docReference = await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .collection('habits')
          .add(habit);
      Map<String, dynamic> fHabit = <String, dynamic>{
        'habitID': docReference.id,
        'userID': userID,
        'goalID': goalID,
        'habitTitle': title,
        'habitNote': note,
        'habitImportance': importance
      };
      _habitModels.add(HabitModel.fromDocument(fHabit));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .collection('habits')
          .doc(docReference.id)
          .update(fHabit);
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //display habits
  Future<void> readHabits({@required userID, @required goalID}) async {
    try {
      _habitModels = <HabitModel>[];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .collection('habits')
          .get()
          .then((QuerySnapshot value) {
        value.docs.forEach((QueryDocumentSnapshot docSnap) {
          _habitModels.add(HabitModel.fromDocument(docSnap.data()));
        });
      });
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //update habit
  Future<void> updateHabit({
    @required String title,
    String note,
    String importance,
    @required String goalID,
    @required String habitID,
    @required String userID,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .collection('habits')
          .doc(habitID)
          .update(<String, dynamic>{
        'habitTitle': title,
        'goalID': goalID,
        'habitID': habitID,
        'userID': userID,
        'habitNote': note,
        'habitImportance': importance
      });
      notifyListeners(); // notify listeners for update
    } catch (e) {
      print(e.toString());
    }
  }

  //delete selected habit
  Future<void> deleteHabit(
      {@required String userID,
      @required String habitID,
      @required String goalID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('goals')
          .doc(goalID)
          .collection('habits')
          .doc(habitID)
          .delete();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  // get goal id
  String _goalID;

  String get goalID => _goalID ?? '';

  set setGoalID(String value) {
    _goalID = value;
    notifyListeners();
  }
}
