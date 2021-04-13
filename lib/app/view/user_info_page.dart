import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/goal_model.dart';
import 'package:working_project/app/models/habit_model.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/welcome_page.dart';

import 'file:///C:/Users/F-IRMA/AndroidStudioProjects/CocuApp/lib/widgets/user_info_widgets/user_info_drawer_widget.dart';
import 'file:///C:/Users/F-IRMA/AndroidStudioProjects/CocuApp/lib/widgets/user_info_widgets/user_info_widget.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  //authentication method
  Future<void> _signOut(BuildContext context) async {
    try {
      await SharedPrefs().setIsLoggedFalse();
      await SharedPrefs().logout();
      final AuthProvider auth =
          Provider.of<AuthProvider>(context, listen: false);
      await auth.logout().then((_) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePageBuilder())));
    } catch (e) {
      print(e);
    }
  }

  //ui
  @override
  Widget build(BuildContext context) {
    //habits count
    final List<HabitModel> habits =
        Provider.of<HabitProvider>(context, listen: true).habitModels;
    //goals count
    final List<GoalModel> goals =
        Provider.of<GoalProvider>(context, listen: true).goalModels;
    //todos count
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).todoModels;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          TextButton(
            onPressed: () => _signOut(context),
            child: Icon(
              Icons.logout,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      drawer: UserInfoDrawer(),
      body: Container(
        child: BuildUserInfo(),
      ),
    );
  }
}
