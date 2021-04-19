import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/goal_model.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/goals_habits/habits_page.dart';

//TODO: Empty Screen
class BuildGoalWidget extends StatelessWidget {
  final Function getInitialData;

  const BuildGoalWidget({Key key, this.getInitialData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPrefs prefs = SharedPrefs();
    final GoalProvider goalProvider =
        Provider.of<GoalProvider>(context, listen: true);
    final List<GoalModel> goals =
        Provider.of<GoalProvider>(context, listen: true).goalModels;
    return ListView(
      children: [
        ListView.separated(
          separatorBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Divider(height: 0.5),
          ),
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemCount: goals.length,
          itemBuilder: (context, int index) {
            final GoalModel goal = goals[index];
            var date = DateTime.parse(goal.dueDate);
            var formattedDate = '${date.day}/${date.month}/${date.year}';
            return ClipRRect(
              child: Dismissible(
                key: Key(goal.goalID.toString()),
                onDismissed: (DismissDirection direction) async {
                  final String userID = await prefs.readUserID();
                  goals.removeAt(index);
                  goalProvider.deleteGoal(goalID: goal.goalID, userID: userID);
                },
                background: Container(
                  margin: const EdgeInsets.only(left: 250),
                  child: Icon(Icons.delete, color: Colors.red),
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HabitsPage(
                          goal: goal,
                        ),
                      ),
                    );
                  },
                  title: Text(goal.goalTitle,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.indigo)),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
