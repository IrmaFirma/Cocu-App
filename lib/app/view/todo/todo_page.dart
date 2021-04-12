import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/goals_habits/goals_page.dart';
import 'package:working_project/app/view/journal/journal_page.dart';
import 'package:working_project/app/view/todo/edit_todo_page.dart';
import 'package:working_project/app/view/user_info_page.dart';

import '../../utils/shared_preferences.dart';
import 'add_todo.dart';
import 'completed_todo.dart';

//TODO Fix Scrolling
//TODO: REFRESH AFTER EDIT
class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  SharedPrefs prefs = SharedPrefs();

  //new snackbar
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
  Widget build(BuildContext context) {
    //refresh every build
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).todoModels;
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    //ui
    return Scaffold(
        appBar: AppBar(
          title: Text('Todo Page'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => CompletedTodo(),
                        fullscreenDialog: true));
              },
              child: Icon(Icons.done, color: Colors.white),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final String userID = await prefs.readUserID();
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return AddNewTodo(userID: userID);
                  },
                  fullscreenDialog: true),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(
                  'Providers App',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
              ),
              ListTile(
                title: Text(
                  'Todo Page',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text(
                  'Account',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomePage(),
                        fullscreenDialog: true)),
              ),
              ListTile(
                title: Text('My journal'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => JournalPage(),
                        fullscreenDialog: true)),
              ),
              ListTile(
                title: Text('My goals and habits'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => GoalPage(),
                        fullscreenDialog: true)),
              ),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: null,
          child: RefreshIndicator(
            onRefresh: () => _getInitialData(),
            child: ListView(
              children: [
                SizedBox(height: 15),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: todos.length,
                  itemBuilder: (context, int index) {
                    final TodoModel todo = todos[index];
                    //formatting date
                    var date = DateTime.parse(todo.date);
                    var formattedDate =
                        '${date.day}/${date.month}/${date.year}';
                    //slidable widget for delete and edit
                    return ClipRRect(
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        key: Key(todo.todoID.toString()),
                        actions: [
                          IconSlideAction(
                              color: Colors.deepOrangeAccent,
                              //edit function call
                              onTap: () async {
                                final String userID = await prefs.readUserID();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EditTodo(
                                            userID: userID,
                                            todo: todo,
                                          ),
                                      fullscreenDialog: true),
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
                              await todoProvider.deleteTodo(
                                  userID: userID, todoID: todo.todoID);
                              showSnackBar(
                                  context, 'Deleted ${todo.title}', Colors.red);
                              _getInitialData();
                            },
                            icon: Icons.delete,
                          )
                        ],
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            value: todo.isCompleted,
                            onChanged: (_) async {
                              final String userID = await prefs.readUserID();
                              todoProvider.markAsDone(
                                  isCompleted: todo.isCompleted,
                                  userID: userID,
                                  todoID: todo.todoID);
                              _getInitialData();
                            },
                          ),
                          onTap: () async {
                            final String userID = await prefs.readUserID();
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) => EditTodo(
                                        userID: userID,
                                        todo: todo,
                                      ),
                                  fullscreenDialog: true),
                            );
                          },
                          title: Text(todo.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.indigo)),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(todo.description)),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text('Due date: $formattedDate')),
                              ],
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
