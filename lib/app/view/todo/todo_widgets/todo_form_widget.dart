import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String buttonText;
  final String dateText;
  final Function dateFunc;
  final Function onSaved;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const TodoFormWidget(
      {Key key,
      @required this.buttonText,
      @required this.dateFunc,
      @required this.onSaved,
      @required this.titleController,
      @required this.descriptionController,
      @required this.dateText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
            child: Text(dateText),
            onPressed: () {
              return dateFunc();
            }),
        TextFormField(
          controller: titleController,
          decoration:
              InputDecoration(labelText: 'Title', hintText: 'Go to NYC'),
          maxLength: 25,
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: descriptionController,
          decoration: InputDecoration(
              labelText: 'Description', hintText: 'Buy plane tickets...'),
        ),
        ElevatedButton(
          child: Text(buttonText),
          onPressed: () async {
            return onSaved();
          },
        ),
      ],
    );
  }
}
