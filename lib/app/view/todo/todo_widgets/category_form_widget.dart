import 'package:flutter/material.dart';
import 'package:working_project/widgets/button_widget.dart';

class CategoryFormWidget extends StatelessWidget {
  final String buttonText;
  final Function onSaved;
  final TextEditingController titleController;
  final TextEditingController notesController;

  const CategoryFormWidget({
    Key key,
    @required this.buttonText,
    @required this.onSaved,
    @required this.titleController,
    @required this.notesController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Title must not be empty!';
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'List Title',
              ),
              maxLength: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: TextFormField(
              controller: notesController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'Notes',
              ),
              maxLines: 7,
            ),
          ),
          ButtonWidget(
            onSaved: () => onSaved(),
            buttonText: buttonText,
          ),
        ],
      ),
    );
  }
}
