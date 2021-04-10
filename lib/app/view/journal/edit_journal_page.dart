import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/journal_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';

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

  void initializeData() {
    _titleController.text = widget.journal.title;
    _subtitleController.text = widget.journal.subtitle;
    _descriptionController.text = widget.journal.description;
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
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit ${widget.journal.title}'),
        backgroundColor: Colors.indigo,
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
                buttonText: 'Update ${widget.journal.title}',
                onSaved: () async {
                  await journalProvider
                      .updateJournal(
                          journalID: widget.journal.journalID,
                          createdDate: createdDate.toString(),
                          title: _titleController.text,
                          subtitle: _subtitleController.text,
                          description: _descriptionController.text,
                          userID: userModel.userID)
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
