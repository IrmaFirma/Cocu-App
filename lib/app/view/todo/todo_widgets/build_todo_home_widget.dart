import 'package:circular_check_box/circular_check_box.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/utils/snack_bar.dart';
import 'package:working_project/app/view/authentication_screens/auth_widgets/email_avatar.dart';
import 'package:working_project/app/view/todo/todo_widgets/congratulations_dialog.dart';
import 'package:working_project/widgets/error_dialog.dart';

import '../edit_todo_page.dart';

class BuildTodoHome extends StatelessWidget {
  final Function getInitialData;

  const BuildTodoHome({@required this.getInitialData});

  @override
  Widget build(BuildContext context) {
    SharedPrefs prefs = SharedPrefs();
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).todoModels;
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    double h = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(width / 35),
          child: Container(
            child: DatePicker(
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Color(0xFF6FCED5),
              onDateChange: null,
              dateTextStyle: TextStyle(
                  color: Color(0xFF696b6e),
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
              height: h / 8,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              todos.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: h / 10),
                          child: Container(
                              height: h / 5,
                              width: width / 2,
                              child: Image.asset('assets/list.png')),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'No todos',
                          style: TextStyle(fontFamily: 'Varela', fontSize: 25),
                        ),
                        Text('Start creating and changing your life',
                            style:
                                TextStyle(fontFamily: 'Varela', fontSize: 15)),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      primary: true,
                      itemCount: todos.length,
                      itemBuilder: (context, int index) {
                        final TodoModel todo = todos[index];
                        //formatting date
                        var date = DateTime.parse(todo.date);
                        var formattedDate =
                            '${date.day}/${date.month}/${date.year}';
                        var leadingDate = '${date.day}';
                        //slidable widget for delete and edit
                        return ClipRRect(
                          child: Row(
                            children: [
                              Container(
                                padding: leadingDate == '1' ||
                                        leadingDate == '2' ||
                                        leadingDate == '3' ||
                                        leadingDate == '4' ||
                                        leadingDate == '5' ||
                                        leadingDate == '6' ||
                                        leadingDate == '7' ||
                                        leadingDate == '8' ||
                                        leadingDate == '9'
                                    ? EdgeInsets.only(
                                        left: width / 19, right: width / 19)
                                    : EdgeInsets.only(
                                        left: width / 41, right: width / 41),
                                child: Text(
                                  leadingDate,
                                  style: TextStyle(
                                      color: Color(0xFF545557),
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 75,
                                  child: Card(
                                    elevation: 1.5,
                                    shadowColor: Color(0xFFced1d6),
                                    child: ListTile(
                                      leading: Wrap(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: CircularCheckBox(
                                              activeColor: Colors.green,
                                              checkColor: Colors.white,
                                              value: todo.isCompleted,
                                              onChanged: (_) async {
                                                final String userID =
                                                    await prefs.readUserID();
                                                todoProvider
                                                    .markAsDone(
                                                        isCompleted:
                                                            todo.isCompleted,
                                                        userID: userID,
                                                        todoID: todo.todoID)
                                                    .then(
                                                      (_) => showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 50),
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .topCenter,
                                                                children: [
                                                                  CongratulationsDialog(
                                                                    todoName: todo
                                                                        .title,
                                                                  ),
                                                                  Avatar(
                                                                    photoURL:
                                                                        'assets/congratulationsIcon.png',
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      )
                                                          .then(
                                                            (_) =>
                                                                getInitialData(),
                                                          )
                                                          .catchError(
                                                            (error) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 50),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
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
                                                          ),
                                                    );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () async {
                                        final String userID =
                                            await prefs.readUserID();
                                        Navigator.push(
                                          context,
                                          CupertinoPageRoute<void>(
                                            builder: (BuildContext context) =>
                                                EditTodo(
                                              userID: userID,
                                              todo: todo,
                                            ),
                                            fullscreenDialog: true,
                                          ),
                                        ).then((_) => getInitialData());
                                      },
                                      title: Wrap(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: Text(
                                              todo.title,
                                              style: TextStyle(
                                                fontSize: 17,
                                                fontFamily: 'Valera',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF2B2B2B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(
                                        'Due $formattedDate',
                                        style: TextStyle(
                                            color: Color(0xFF6FCED5),
                                            fontSize: 15),
                                      ),
                                      trailing: Wrap(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 3),
                                            child: IconButton(
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
                                                    .then(
                                                  (_) {
                                                    getInitialData();
                                                    showSnackBar(
                                                        context,
                                                        'Deleted ${todo.title}',
                                                        Colors.red);
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
            ],
          ),
        ),
      ],
    );
  }
}
