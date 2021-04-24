import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/category_todo_model.dart';
import 'package:working_project/app/providers/category_todo_provider.dart';
import 'package:working_project/app/view/authentication_screens/auth_widgets/avatar.dart';
import 'package:working_project/app/view/todo/todo_widgets/category_form_widget.dart';
import 'package:working_project/widgets/error_dialog.dart';

class EditCategory extends StatefulWidget {
  const EditCategory({this.categoryTodo, this.userID});

  final CategoryTodoModel categoryTodo;
  final String userID;

  @override
  _EditCategoryState createState() => _EditCategoryState();
}

class _EditCategoryState extends State<EditCategory> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  String date = DateTime.now().toString();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void initializeData() {
    _titleController.text = widget.categoryTodo.categoryTitle;
    _notesController.text = widget.categoryTodo.categoryNote;
  }

  @override
  void initState() {
    super.initState();
    initializeData();
  }

  @override
  Widget build(BuildContext context) {
    final CategoryTodoProvider categoryTodoProvider =
        Provider.of<CategoryTodoProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Update ${widget.categoryTodo.categoryTitle}'),
        backgroundColor: Color(0xFFFBC490),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: formKey,
              child: CategoryFormWidget(
                buttonText: 'SAVE',
                titleController: _titleController,
                notesController: _notesController,
                onSaved: () async {
                  await categoryTodoProvider
                      .updateCategory(
                        categoryID: widget.categoryTodo.categoryID,
                        userID: widget.userID,
                        title: _titleController.text,
                        notes: _notesController.text,
                      )
                      .then((_) => Navigator.of(context).pop())
                      .catchError(
                        (_) => Padding(
                          padding: const EdgeInsets.only(top: 50),
                          child: Container(
                            alignment: Alignment.center,
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                ErrorDialog(),
                                Avatar(
                                  photoURL: 'assets/errorIcon.png',
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
