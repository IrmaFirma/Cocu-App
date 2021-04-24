import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/category_todo_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/todo_widgets/build_todo_home_widget.dart';

import '../../utils/shared_preferences.dart';
import 'add_todo.dart';
import 'completed_todo.dart';

class TodoPage extends StatefulWidget {
  final String categoryID;

  const TodoPage({Key key, @required this.categoryID}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  //authentication and data fetch functions
  SharedPrefs prefs = SharedPrefs();

  //TODO Instead of reading ToDo's read Categories move this logic to Todo Category List
  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<TodoProvider>(context, listen: false)
            .readTodo(userID: userID, categoryID: widget.categoryID);
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<TodoProvider>(context, listen: false)
          .readTodo(userID: userModel.userID, categoryID: widget.categoryID);
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
                        builder: (BuildContext context) => CompletedTodo(
                              categoryID: widget.categoryID,
                            ),
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
                      return AddNewTodo(
                        userID: userID,
                        categoryID: widget.categoryID,
                      );
                    },
                  ),
                );
              },
            ),
          ],
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
              child: BuildTodoHome(
                getInitialData: () async {
                  await _getInitialData();
                },
                categoryID: widget.categoryID,
              ),
            ),
          ),
        ));
  }
}
