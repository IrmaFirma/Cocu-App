import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:working_project/app/models/journal_model.dart';

class JournalProvider extends ChangeNotifier {
  List<JournalModel> _journalModels = <JournalModel>[];

  //getter for the list of journal model
  List<JournalModel> get journalModels => _journalModels;

  // add new journal
  Future<void> addJournal({
    @required String title,
    @required String createdDate,
    @required String description,
    @required userID,
    String subtitle,
  }) async {
    try {
      Map<String, dynamic> journal = <String, dynamic>{
        'journal_id': '',
        'created_date': createdDate,
        'title': title,
        'user_id': userID,
        'description': description,
        'subtitle': subtitle,
      };
      final DocumentReference documentReference = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userID)
          .collection('journal')
          .add(journal);
      Map<String, dynamic> fJournal = <String, dynamic>{
        'journal_id': documentReference.id,
        'created_date': createdDate,
        'title': title,
        'user_id': userID,
        'description': description,
        'subtitle': subtitle
      };
      //from document (json)
      _journalModels.add(JournalModel.fromDocument(fJournal));
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('journal')
          .doc(documentReference.id)
          .update(fJournal); //update with new document
      notifyListeners(); //notify for changes
    } catch (e) {
      print(e.toString());
    }
  }

  //delete journal method
  Future<void> deleteJournal(
      {@required String userID, @required String journalID}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('journal')
          .doc(journalID)
          .delete();
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  //update Journal method for edit implementation
  Future<void> updateJournal(
      {@required String title,
      @required String description,
      @required String journalID,
      @required String userID,
      String subtitle,
      String createdDate}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('journal')
          .doc(journalID)
          .update(<String, dynamic>{
        'title': title,
        'subtitle': subtitle,
        'description': description,
        'journal_id': journalID,
        'user_id': userID,
        'created_date': createdDate
      });
      notifyListeners(); // notify listeners for update
    } catch (e) {
      print(e.toString());
    }
  }

  //displaying all documents in journal collection form specific user
  Future<void> readJournal({@required userID}) async {
    try {
      _journalModels = <JournalModel>[];
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .collection('journal')
          .get()
          .then((QuerySnapshot value) {
        value.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
          _journalModels.add(JournalModel.fromDocument(documentSnapshot
              .data())); //read every document in that users journal collection
        });
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
