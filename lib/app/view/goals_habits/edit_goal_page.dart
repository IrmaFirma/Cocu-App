import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/goal_model.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';

import 'goal_widgets/goal_form_widget.dart';

class EditGoal extends StatefulWidget {
  const EditGoal({this.goal});

  final GoalModel goal;

  @override
  _EditGoalState createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  final TextEditingController _titleController = TextEditingController();
  String date = DateTime.now().toString();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SharedPrefs prefs = SharedPrefs();

  void initializeData() {
    _titleController.text = widget.goal.goalTitle;
    date = widget.goal.date;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

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
        title: Text('Edit ${widget.goal.goalTitle}'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: GoalFormWidget(
                controller: _titleController,
                buttonText: 'Update ${widget.goal.goalTitle}',
                dateText: '$formattedDate',
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
                  final String userID = await prefs.readUserID();
                  await goalProvider
                      .updateGoal(
                          title: _titleController.text,
                          goalID: widget.goal.goalID,
                          userID: userID,
                          date: date)
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
