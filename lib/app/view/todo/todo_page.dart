import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/goals_habits/goals_page.dart';
import 'package:working_project/app/view/journal/journal_page.dart';
import 'package:working_project/app/view/todo/todo_widgets/build_todo_home_widget.dart';
import 'package:working_project/app/view/user_info_page.dart';
import 'package:working_project/widgets/drawer_widget.dart';

import '../../utils/shared_preferences.dart';
import 'add_todo.dart';
import 'completed_todo.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  //authentication and data fetch functions
  SharedPrefs prefs = SharedPrefs();

  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<TodoProvider>(context, listen: false).readTodo(
          userID: userID,
        );
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<TodoProvider>(context, listen: false).readTodo(
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
    precacheImage(const AssetImage('assets/todoBack.png'), context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: const Text(
            'ToDo',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFFCFCFC),
          actions: [
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => CompletedTodo(),
                        fullscreenDialog: true));
              },
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final String userID = await prefs.readUserID();
                Navigator.push(
                  context,
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) {
                      return AddNewTodo(userID: userID);
                    },
                  ),
                );
              },
            ),
          ],
        ),
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
          secondEFunction: () => print('Already selected'),
          thirdEFunction: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => GoalPage(),
                  fullscreenDialog: true)),
          fourthEFunction: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => JournalPage(),
                  fullscreenDialog: true)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: AssetImage('assets/todoBack.png') != null
                ? DecorationImage(
                    image: AssetImage('assets/todoBack.png'),
                    fit: BoxFit.fill,
                  )
                : null,
          ),
          child: WillPopScope(
            onWillPop: null,
            child: RefreshIndicator(
              onRefresh: () => _getInitialData(),
              child: BuildTodoHome(getInitialData: () async {
                await _getInitialData();
              }),
            ),
          ),
        ));
  }
}
