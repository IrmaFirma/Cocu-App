import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/view/todo/todo_widgets/todo_form_widget.dart';

class AddNewTodo extends StatefulWidget {
  final String userID;
  final String categoryID;

  const AddNewTodo({Key key, this.userID, this.categoryID}) : super(key: key);

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
        '${dateFormat.day} - ${dateFormat.month} - ${dateFormat.year}';
    final TodoProvider todoProvider =
        Provider.of<TodoProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add ToDo'),
        backgroundColor: Color(0xFFFBC490),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: TodoFormWidget(
                dateText: '$formattedDate',
                dateFunc: () async {
                  await showDatePicker(
                    cancelText: '',
                    confirmText: 'DONE',
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2040),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        date = value.toString();
                      });
                    }
                  });
                },
                buttonText: 'ADD',
                titleController: _titleController,
                descriptionController: _descriptionController,
                onSaved: () async {
                  if (formKey.currentState.validate()) {
                    await todoProvider
                        .addTodo(
                            categoryID: widget.categoryID,
                            isCompleted: false,
                            userID: widget.userID,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            date: date)
                        .then((_) => Navigator.of(context).pop());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
