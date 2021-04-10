import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/goal_provider.dart';

import 'goal_widgets/goal_form_widget.dart';

class AddNewGoal extends StatefulWidget {
  @override
  _AddNewGoalState createState() => _AddNewGoalState();
}

class _AddNewGoalState extends State<AddNewGoal> {
  final TextEditingController _titleController = TextEditingController();
  String date = DateTime.now().toString();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //formatted date
    var dateFormat = DateTime.parse(date);
    var formattedDate =
        '${dateFormat.day}/${dateFormat.month}/${dateFormat.year}';
    final GoalProvider goalProvider =
        Provider.of<GoalProvider>(context, listen: true);
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Goal'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: GoalFormWidget(
                dateText: '$formattedDate',
                buttonText: 'Save',
                controller: _titleController,
                dateFunc: () {
                  return showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((value) => setState(() {
                        date = value.toString();
                      }));
                },
                onSaved: () async {
                  await goalProvider
                      .addGoal(
                          date: date,
                          title: _titleController.text,
                          userID: userModel.userID)
                      .then((_) {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
