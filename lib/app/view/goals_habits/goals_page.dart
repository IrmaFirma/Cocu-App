import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/goals_habits/goal_widgets/build_goal_widget.dart';
import 'package:working_project/app/view/journal/journal_page.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'package:working_project/widgets/app_bar_widget.dart';
import 'package:working_project/widgets/drawer_widget.dart';

import '../user_info_page.dart';
import 'add_goal_page.dart';

class GoalPage extends StatefulWidget {
  @override
  _GoalPageState createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  SharedPrefs prefs = SharedPrefs();

  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<GoalProvider>(context, listen: false).readGoal(
          userID: userID,
        );
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<GoalProvider>(context, listen: false).readGoal(
        userID: userModel.userID,
      );
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
    //ui
    return Scaffold(
        appBar: commonAppBar(
            barText: 'Goal Station',
            addNew: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddNewGoal()))),
        drawer: CommonDrawer(
          firstElementTitle: 'Home Page',
          secondElementTitle: 'ToDo',
          thirdElementTitle: 'Goals and Habits',
          fourthElementTitle: 'Journal',
          firstEFunction: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => UserInfoPage(),
                  fullscreenDialog: true)),
          secondEFunction: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => TodoPage(),
                  fullscreenDialog: true)),
          thirdEFunction: null,
          fourthEFunction: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => JournalPage(),
                  fullscreenDialog: true)),
        ),
        body: WillPopScope(
          onWillPop: null,
          child: RefreshIndicator(
              onRefresh: () => _getInitialData(),
              child: BuildGoalWidget(
                getInitialData: () async {
                  await _getInitialData();
                },
              )),
        ));
  }
}
