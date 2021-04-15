import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/todo_widgets/build_completed_widget.dart';

//TODO Fix Scrolling
class CompletedTodo extends StatefulWidget {
  @override
  _CompletedTodoState createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
  SharedPrefs prefs = SharedPrefs();

  AssetImage completedBack;

  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<TodoProvider>(context, listen: false).readCompletedTodo(
          userID: userID,
        );
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<TodoProvider>(context, listen: false).readCompletedTodo(
        userID: userModel.userID,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitialData();
    completedBack = AssetImage('assets/completedBack.png');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(completedBack, context);
  }

  @override
  Widget build(BuildContext context) {
    //ui
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: const Text(
            'Completed',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFFCFCFC),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: completedBack != null
                ? DecorationImage(
                    image: AssetImage('assets/completedBack.png'),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: WillPopScope(
            onWillPop: null,
            child: RefreshIndicator(
              onRefresh: () => _getInitialData(),
              child: BuildCompletedTodo(getInitialData: () {
                return _getInitialData();
              }),
            ),
          ),
        ));
  }
}
