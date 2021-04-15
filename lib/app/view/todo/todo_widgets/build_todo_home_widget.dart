import 'package:circular_check_box/circular_check_box.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/authentication_screens/auth_widgets/email_avatar.dart';
import 'package:working_project/app/view/todo/todo_widgets/congratulations_dialog.dart';
import 'package:working_project/widgets/error_dialog.dart';

import '../edit_todo_page.dart';

class BuildTodoHome extends StatelessWidget {
  final Function getInitialData;

  //TODO ERROR
  //TODO COMPLETED

  const BuildTodoHome({@required this.getInitialData});

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
  Widget build(BuildContext context) {
    SharedPrefs prefs = SharedPrefs();
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).todoModels;
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DatePicker(
            DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: Color(0xFF6B9BBB),
            onDateChange: null,
            dateTextStyle: TextStyle(
                color: Color(0xFF696b6e),
                fontSize: 24,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView(
            children: [
              SizedBox(height: 15),
              todos.isEmpty
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 80),
                          child: Container(
                              height: 154,
                              width: 154,
                              child: Image.asset('assets/emptyTodo.png')),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'No todos',
                          style: TextStyle(fontFamily: 'Varela', fontSize: 26),
                        ),
                        Text('Start creating and changing your life',
                            style:
                                TextStyle(fontFamily: 'Varela', fontSize: 16)),
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 10, left: 12, right: 12),
                                child: Text(
                                  leadingDate,
                                  style: TextStyle(
                                      color: Color(0xFF545557),
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato'),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    height: 82,
                                    child: Card(
                                      elevation: 1.5,
                                      shadowColor: Color(0xFFced1d6),
                                      child: ListTile(
                                        leading: Wrap(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
                                                                      todoName:
                                                                          todo.title,
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
                                                              (error) =>
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top:
                                                                            50),
                                                                child:
                                                                    Container(
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
                                                  const EdgeInsets.only(top: 5),
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
                                              color: Color(0xFF6B9BBB),
                                              fontSize: 15),
                                        ),
                                        trailing: Wrap(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
