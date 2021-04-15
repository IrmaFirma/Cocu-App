import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/habit_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/widgets/app_bar_widget.dart';

import '../../models/goal_model.dart';
import 'add_habit_page.dart';
import 'edit_habit_page.dart';

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
    _getInitialData();
  }

  @override
  Widget build(BuildContext context) {
    final HabitProvider habitProvider =
        Provider.of<HabitProvider>(context, listen: true);
    final List<HabitModel> habits =
        Provider.of<HabitProvider>(context, listen: true).habitModels;
    return Scaffold(
      appBar: commonAppBar(
        barText: 'Habits for ${widget.goal.goalTitle}',
        addNew: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddNewHabit(),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: null,
        child: RefreshIndicator(
          onRefresh: () => _getInitialData(),
          child: ListView(
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
                                    goal: widget.goal,
                                    habit: habit,
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
                          onTap: () async {
                            final String userID = await prefs.readUserID();
                            await habitProvider.deleteHabit(
                                userID: userID,
                                habitID: habit.habitID,
                                goalID: widget.goal.goalID);
                            _getInitialData();
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
