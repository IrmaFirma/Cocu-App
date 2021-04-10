import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/view/todo/todo_widgets/todo_form_widget.dart';

class AddNewTodo extends StatefulWidget {
  final UserModel userModel;

  const AddNewTodo({Key key, this.userModel}) : super(key: key);

  @override
  _AddNewTodoState createState() => _AddNewTodoState();
}

class _AddNewTodoState extends State<AddNewTodo> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  String date = DateTime.now().toString();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateTime.parse(date);
    var formattedDate =
        '${dateFormat.day}/${dateFormat.month}/${dateFormat.year}';
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Todo'),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TodoFormWidget(
                dateText: '$formattedDate',
                dateFunc: () {
                  return showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((value) => setState(() {
                        date = value.toString();
                      }));
                },
                buttonText: 'Save',
                titleController: _titleController,
                descriptionController: _descriptionController,
                onSaved: () {
                  todoProvider
                      .addTodo(
                          isCompleted: false,
                          userID: authProvider.userModel.userID,
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date: date)
                      .then((_) => Navigator.of(context).pop());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
