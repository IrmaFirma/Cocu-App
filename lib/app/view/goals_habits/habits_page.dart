import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/goals_habits/habit_widgets/build_habit_widget.dart';
import 'package:working_project/widgets/app_bar_widget.dart';

import '../../models/goal_model.dart';
import 'add_habit_page.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({this.goal});

  final GoalModel goal;

  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  SharedPrefs prefs = SharedPrefs();

  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<HabitProvider>(context, listen: false)
            .readHabits(userID: userID, goalID: widget.goal.goalID);
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<HabitProvider>(context, listen: false)
          .readHabits(userID: userModel.userID, goalID: widget.goal.goalID);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        barText: 'Habits for ${widget.goal.goalTitle}',
        addNew: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddNewHabit(
              goal: widget.goal,
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: null,
        child: RefreshIndicator(
            onRefresh: () => _getInitialData(),
            child: BuildHabitWidget(
              goal: widget.goal,
              getInitialData: () async {
                await _getInitialData();
              },
            )),
      ),
    );
  }
}
