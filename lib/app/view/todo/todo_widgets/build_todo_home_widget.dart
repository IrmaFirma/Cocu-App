import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/utils/snack_bar.dart';
import 'package:working_project/app/view/authentication_screens/auth_widgets/avatar.dart';
import 'package:working_project/app/view/todo/todo_widgets/congratulations_dialog.dart';
import 'package:working_project/widgets/error_dialog.dart';

import '../edit_todo_page.dart';

class BuildTodoHome extends StatefulWidget {
  final Function getInitialData;

  const BuildTodoHome({@required this.getInitialData});

  @override
  _BuildTodoHomeState createState() => _BuildTodoHomeState();
}

class _BuildTodoHomeState extends State<BuildTodoHome> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    SharedPrefs prefs = SharedPrefs();
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).todoModels;
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TableCalendar(
            startingDayOfWeek: StartingDayOfWeek.monday,
            initialCalendarFormat: CalendarFormat.week,
            headerStyle: HeaderStyle(
              formatButtonShowsNext: false,
            ),
            calendarStyle: CalendarStyle(
                weekendStyle: TextStyle(color: Colors.grey.shade700),
                weekdayStyle: TextStyle(color: Colors.grey.shade700),
                todayColor: Color(0xFF6FCED5),
                selectedColor: Color(0xFF6FCED5),
                todayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white)),
            calendarController: _calendarController),
        Expanded(
          child: ListView(
            children: [
              todos.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height / 10),
                          child: Container(
                              height: height / 5,
                              width: width / 2,
                              child: Image.asset('assets/list.png')),
                        ),
                        SizedBox(
                          height: height / 55,
                        ),
                        Text(
                          'No todos',
                          style: TextStyle(
                              fontFamily: 'Varela', fontSize: width / 15),
                        ),
                        Text('Start creating and changing your life',
                            style: TextStyle(
                                fontFamily: 'Varela', fontSize: width / 25)),
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
                        var date = DateTime.parse(todo.dueDate);
                        var formattedDate =
                            '${date.day}/${date.month}/${date.year}';
                        return ClipRRect(
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: width / 25, right: width / 25),
                                  child: Container(
                                    height: 75,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      elevation: 1.5,
                                      shadowColor: Color(0xFFced1d6),
                                      child: ListTile(
                                        leading: Wrap(
                                          children: [
                                            CircularCheckBox(
                                              inactiveColor: Color(0xFF6FCED5),
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
                                                                        .todoTitle,
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
                                                            (_) => widget
                                                                .getInitialData(),
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
                                          ).then(
                                              (_) => widget.getInitialData());
                                        },
                                        title: Wrap(
                                          children: [
                                            Text(
                                              todo.todoTitle,
                                              style: TextStyle(
                                                fontSize: width / 24,
                                                fontFamily: 'Valera',
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF2B2B2B),
                                              ),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                          'Due $formattedDate',
                                          style:
                                              TextStyle(fontSize: width / 30),
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
                                                    .then(
                                                  (_) {
                                                    widget.getInitialData();
                                                    showSnackBar(
                                                        context,
                                                        'Deleted ${todo.todoTitle}',
                                                        Colors.red);
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        ),
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
