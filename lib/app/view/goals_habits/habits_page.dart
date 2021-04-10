import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/habit_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/habits_provider.dart';

import '../../models/goal_model.dart';
import 'add_habit_page.dart';
import 'edit_habit_page.dart';

//TODO Fix Scrolling
class HabitsPage extends StatefulWidget {
  const HabitsPage({this.goal});

  final GoalModel goal;

  @override
  _HabitsPageState createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  Future<void> _refreshScreenForChanges() async {
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel;
    Provider.of<HabitProvider>(context, listen: false)
        .readHabits(userID: userModel.userID, goalID: widget.goal.goalID);
  }

  void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshScreenForChanges();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: true).userModel;
    final HabitProvider habitProvider =
        Provider.of<HabitProvider>(context, listen: true);
    final List<HabitModel> habits =
        Provider.of<HabitProvider>(context, listen: true).habitModels;
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit maker'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => AddNewHabit(goal: widget.goal),
              fullscreenDialog: true),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.indigo,
      ),
      body: WillPopScope(
        onWillPop: null,
        child: RefreshIndicator(
          onRefresh: () => _refreshScreenForChanges(),
          child: ListView(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
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
                                    goal: widget.goal,
                                  ),
                                ),
                              );
                            },
                            caption: 'Edit',
                            icon: Icons.edit)
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          color: Colors.red,
                          caption: 'Delete',
                          //delete function call
                          onTap: () {
                            habitProvider.deleteHabit(
                                userID: userModel.userID,
                                habitID: habit.habitID,
                                goalID: widget.goal.goalID);
                            _refreshScreenForChanges();
                            showSnackBar(context, 'Deleted ${habit.habitTitle}',
                                Colors.red);
                          },
                          icon: Icons.delete,
                        )
                      ],
                      child: ListTile(
                        //TODO: onTap showing edit page(details)
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
          ),
        ),
      ),
    );
  }
}
