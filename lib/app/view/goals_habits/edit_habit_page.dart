import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/goal_model.dart';
import 'package:working_project/app/models/habit_model.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';

import 'habit_widgets/habit_form_widget.dart';

class EditHabit extends StatefulWidget {
  const EditHabit({this.habit, this.goal});

  final HabitModel habit;
  final GoalModel goal;

  @override
  _EditHabitState createState() => _EditHabitState();
}

class _EditHabitState extends State<EditHabit> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _importanceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final SharedPrefs prefs = SharedPrefs();

  void initializeData() {
    _titleController.text = widget.habit.habitTitle;
    _noteController.text = widget.habit.habitNote;
    _importanceController.text = widget.habit.habitImportance;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final HabitProvider habitProvider =
        Provider.of<HabitProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Update ${widget.habit.habitTitle}'),
        backgroundColor: Color(0xFFFBC490),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: HabitFormWidget(
                titleController: _titleController,
                subtitleController: _noteController,
                importanceController: _importanceController,
                buttonText: 'UPDATE',
                onSaved: () async {
                  final String userID = await prefs.readUserID();
                  await habitProvider
                      .updateHabit(
                          habitID: widget.habit.habitID,
                          goalID: widget.goal.goalID,
                          title: _titleController.text,
                          note: _noteController.text,
                          importance: _importanceController.text,
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
