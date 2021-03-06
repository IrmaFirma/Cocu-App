import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/journal_model.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';

import '../../models/journal_model.dart';
import 'journal_widgets/journal_form_widget.dart';

class EditJournal extends StatefulWidget {
  const EditJournal({this.journal});

  final JournalModel journal;

  @override
  _EditJournalState createState() => _EditJournalState();
}

class _EditJournalState extends State<EditJournal> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _subtitleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  DateTime createdDate = DateTime.now();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final SharedPrefs prefs = SharedPrefs();

  void initializeData() {
    _titleController.text = widget.journal.journalTitle;
    _subtitleController.text = widget.journal.journalSubtitle;
    _descriptionController.text = widget.journal.journalDescription;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final JournalProvider journalProvider =
        Provider.of<JournalProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Update ${widget.journal.journalTitle}'),
        backgroundColor: Color(0xFFFBC490),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: JournalFormWidget(
                titleController: _titleController,
                subtitleController: _subtitleController,
                descriptionController: _descriptionController,
                buttonText: 'UPDATE',
                onSaved: () async {
                  final String userID = await prefs.readUserID();
                  await journalProvider
                      .updateJournal(
                          journalID: widget.journal.journalID,
                          createdDate: createdDate.toString(),
                          title: _titleController.text,
                          subtitle: _subtitleController.text,
                          description: _descriptionController.text,
                          userID: userID)
                      .then(
                    (_) {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
