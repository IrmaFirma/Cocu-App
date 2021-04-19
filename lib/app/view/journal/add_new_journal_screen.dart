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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Page'),
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
                buttonText: 'ADD',
                onSaved: () async {
                  final String userID = await prefs.readUserID();
                  if (formKey.currentState.validate()) {
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
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
