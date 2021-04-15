import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/goal_model.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/utils/snack_bar.dart';
import 'package:working_project/app/view/goals_habits/edit_goal_page.dart';
import 'package:working_project/app/view/goals_habits/habits_page.dart';

//TODO: Remove Slidable
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
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemCount: goals.length,
          itemBuilder: (context, int index) {
            final GoalModel goal = goals[index];
            var date = DateTime.parse(goal.date);
            var formattedDate = '${date.day}/${date.month}/${date.year}';
            return ClipRRect(
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                key: Key(goal.goalID.toString()),
                actions: [
                  IconSlideAction(
                      color: Colors.deepOrangeAccent,
                      //edit function call
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditGoal(
                              goal: goal,
                            ),
                          ),
                        ).then((_) {
                          getInitialData();
                        });
                      },
                      caption: 'Edit',
                      icon: Icons.edit)
                ],
                secondaryActions: [
                  IconSlideAction(
                    color: Colors.red,
                    caption: 'Delete',
                    //delete function call
                    onTap: () async {
                      final String userID = await prefs.readUserID();
                      await goalProvider
                          .deleteGoal(goalID: goal.goalID, userID: userID)
                          .then((value) {
                        getInitialData();
                        showSnackBar(
                            context, 'Deleted ${goal.goalTitle}', Colors.red);
                      });
                    },
                    icon: Icons.delete,
                  )
                ],
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
                  subtitle: Text('Due date: $formattedDate'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
