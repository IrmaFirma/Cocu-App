import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/view/journal/journal_widgets/journal_form_widget.dart';

class AddNewJournal extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _subtitleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final DateTime createdDate = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final JournalProvider journalProvider =
        Provider.of<JournalProvider>(context, listen: true);
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel;
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
                  await journalProvider
                      .addJournal(
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
            )
          ],
        ),
      ),
    );
  }
}
