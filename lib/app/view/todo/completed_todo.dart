import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/view/todo/edit_todo_page.dart';

//TODO Fix Scrolling
class CompletedTodo extends StatefulWidget {
  @override
  _CompletedTodoState createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
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

  Future<void> _refreshScreenForChanges() async {
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel;
    Provider.of<TodoProvider>(context, listen: false).readCompletedTodo(
      userID: userModel.userID,
    );
  }

  @override
  Widget build(BuildContext context) {
    //refresh every build
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: true).userModel;
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).completedModels;
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    _refreshScreenForChanges();
    //ui
    return Scaffold(
        appBar: AppBar(
          title: Text('Completed Todo'),
        ),
        body: WillPopScope(
          onWillPop: null,
          child: RefreshIndicator(
            onRefresh: () => _refreshScreenForChanges(),
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
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          EditTodo(
                                            userModel: userModel,
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
                              await todoProvider.deleteTodo(
                                  userID: userModel.userID,
                                  todoID: todo.todoID);
                              _refreshScreenForChanges();
                              showSnackBar(
                                  context, 'Deleted ${todo.title}', Colors.red);
                            },
                            icon: Icons.delete,
                          )
                        ],
                        child: ListTile(
                          leading: Checkbox(
                            activeColor: Colors.green,
                            checkColor: Colors.white,
                            value: todo.isCompleted,
                            onChanged: (_) {
                              todoProvider.markAsDone(
                                  isCompleted: todo.isCompleted,
                                  userID: userModel.userID,
                                  todoID: todo.todoID);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                  builder: (BuildContext context) => EditTodo(
                                        userModel: userModel,
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
