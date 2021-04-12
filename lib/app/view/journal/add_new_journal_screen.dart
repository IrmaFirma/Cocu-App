import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/journal/journal_widgets/journal_form_widget.dart';

class AddNewJournal extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DateTime createdDate = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    final JournalProvider journalProvider =
        Provider.of<JournalProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Journal'),
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
                buttonText: 'Save',
                onSaved: () async {
                  final String userID = await prefs.readUserID();
                  await journalProvider
                      .addJournal(
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
            )
          ],
        ),
      ),
    );
  }
}
