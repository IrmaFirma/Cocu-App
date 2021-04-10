import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/view/todo/todo_widgets/todo_form_widget.dart';

class EditTodo extends StatefulWidget {
  const EditTodo({this.todo, this.userModel});

  final TodoModel todo;
  final UserModel userModel;

  @override
  _EditTodoState createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String date = DateTime.now().toString();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initializeData() {
    _titleController.text = widget.todo.title;
    date = widget.todo.date;
    _descriptionController.text = widget.todo.description;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    var dateFormat = DateTime.parse(date);
    var formattedDate =
        '${dateFormat.day}/${dateFormat.month}/${dateFormat.year}';
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Update ${widget.todo.title}'),
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
                buttonText: 'Update ${widget.todo.title} ',
                titleController: _titleController,
                descriptionController: _descriptionController,
                onSaved: () {
                  todoProvider
                      .updateTodo(
                          todoID: widget.todo.todoID,
                          userID: widget.userModel.userID,
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
