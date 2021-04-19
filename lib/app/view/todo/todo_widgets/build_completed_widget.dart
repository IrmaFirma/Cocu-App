import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/authentication_screens/auth_widgets/avatar.dart';
import 'package:working_project/widgets/error_dialog.dart';

import '../edit_todo_page.dart';

class BuildCompletedTodo extends StatelessWidget {
  final Function getInitialData;

  const BuildCompletedTodo({@required this.getInitialData});

  void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SharedPrefs prefs = SharedPrefs();
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).completedModels;
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: width / 25, right: width / 25),
            child: ListView(
              children: [
                SizedBox(height: 15),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  primary: true,
                  scrollDirection: Axis.vertical,
                  itemCount: todos.length,
                  itemBuilder: (context, int index) {
                    final TodoModel todo = todos[index];
                    //formatting date
                    var date = DateTime.parse(todo.date);
                    var formattedDate =
                        '${date.day}/${date.month}/${date.year}';
                    //slidable widget for delete and edit
                    return Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 75,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 1.5,
                              shadowColor: Color(0xFFced1d6),
                              child: ListTile(
                                leading: Wrap(
                                  children: [
                                    CircularCheckBox(
                                      activeColor: Colors.green,
                                      checkColor: Colors.white,
                                      value: todo.isCompleted,
                                      onChanged: (value) {
                                        print(value);
                                      },
                                    ),
                                  ],
                                ),
                                onTap: () async {
                                  final String userID =
                                      await prefs.readUserID();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
                                            EditTodo(
                                              userID: userID,
                                              todo: todo,
                                            ),
                                        fullscreenDialog: true),
                                  ).then((_) => getInitialData());
                                },
                                title: Wrap(
                                  children: [
                                    Text(
                                      todo.title,
                                      style: TextStyle(
                                        fontSize: width / 24,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF2B2B2B),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  'Due $formattedDate',
                                  style: TextStyle(
                                    fontSize: width / 30,
                                  ),
                                ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Color(0xFFf5625d),
                                      ),
                                      onPressed: () async {
                                        final String userID =
                                            await prefs.readUserID();
                                        await todoProvider
                                            .deleteTodo(
                                                userID: userID,
                                                todoID: todo.todoID)
                                            .then((_) async {
                                          showSnackBar(
                                              context,
                                              'Deleted ${todo.title}',
                                              Colors.red);
                                          getInitialData();
                                        }).catchError(
                                          (_) => Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Stack(
                                                alignment: Alignment.topCenter,
                                                children: [
                                                  ErrorDialog(),
                                                  Avatar(
                                                    photoURL:
                                                        'assets/errorIcon.png',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
