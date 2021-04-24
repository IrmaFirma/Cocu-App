import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/category_todo_provider.dart';
import 'package:working_project/app/view/todo/todo_widgets/category_form_widget.dart';

class AddNewCategory extends StatefulWidget {
  final String userID;

  const AddNewCategory({Key key, this.userID}) : super(key: key);

  @override
  _AddNewCategoryState createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _notesController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final CategoryTodoProvider categoryTodoProvider =
        Provider.of<CategoryTodoProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add List'),
        backgroundColor: Color(0xFFFBC490),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: CategoryFormWidget(
                buttonText: 'ADD',
                titleController: _titleController,
                notesController: _notesController,
                onSaved: () async {
                  if (formKey.currentState.validate()) {
                    await categoryTodoProvider
                        .addCategory(
                          userID: widget.userID,
                          title: _titleController.text,
                          notes: _notesController.text,
                        )
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
