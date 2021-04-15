import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';

import 'goal_widgets/goal_form_widget.dart';

class AddNewGoal extends StatefulWidget {
  @override
  _AddNewGoalState createState() => _AddNewGoalState();
}

class _AddNewGoalState extends State<AddNewGoal> {
  final TextEditingController _titleController = TextEditingController();
  String date = DateTime.now().toString();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SharedPrefs prefs = SharedPrefs();

  @override
  Widget build(BuildContext context) {
    //formatted date
    var dateFormat = DateTime.parse(date);
    var formattedDate =
        '${dateFormat.day}/${dateFormat.month}/${dateFormat.year}';
    final GoalProvider goalProvider =
        Provider.of<GoalProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Goal'),
        backgroundColor: Color(0xFFFBC490),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: GoalFormWidget(
                dateText: '$formattedDate',
                buttonText: 'ADD',
                controller: _titleController,
                dateFunc: () {
                  return showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        date = value.toString();
                      });
                    }
                  });
                },
                onSaved: () async {
                  final String userID = await prefs.readUserID();
                  await goalProvider
                      .addGoal(
                          date: date,
                          title: _titleController.text,
                          userID: userID)
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
