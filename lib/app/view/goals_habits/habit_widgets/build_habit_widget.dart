import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/goal_model.dart';
import 'package:working_project/app/models/habit_model.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/utils/snack_bar.dart';
import 'package:working_project/app/view/goals_habits/edit_habit_page.dart';

//TODO: Remove Slidable
//TODO: Empty Screen
class BuildHabitWidget extends StatelessWidget {
  final GoalModel goal;
  final Function getInitialData;

  const BuildHabitWidget({Key key, this.goal, this.getInitialData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPrefs prefs = SharedPrefs();
    final HabitProvider habitProvider =
        Provider.of<HabitProvider>(context, listen: true);
    final List<HabitModel> habits =
        Provider.of<HabitProvider>(context, listen: true).habitModels;
    return ListView(
      children: [
        ListView.builder(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          primary: true,
          itemCount: habits.length,
          itemBuilder: (context, int index) {
            final HabitModel habit = habits[index];
            //slidable widget for delete and edit
            return ClipRRect(
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                key: Key(habit.habitID.toString()),
                actions: [
                  IconSlideAction(
                      color: Colors.deepOrangeAccent,
                      //edit function call
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditHabit(
                              goal: goal,
                              habit: habit,
                            ),
                          ),
                        ).then((_) => getInitialData());
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
                      await habitProvider
                          .deleteHabit(
                              userID: userID,
                              habitID: habit.habitID,
                              goalID: goal.goalID)
                          .then((_) {
                        getInitialData();
                        showSnackBar(
                            context, 'Deleted ${habit.habitTitle}', Colors.red);
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
                        builder: (context) => EditHabit(
                          goal: goal,
                          habit: habit,
                        ),
                      ),
                    ).then((_) => getInitialData());
                  },
                  title: Text(habit.habitTitle,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.indigo)),
                  subtitle: Text(habit.habitNote),
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
