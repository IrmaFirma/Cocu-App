import 'package:flutter/material.dart';

class HabitFormWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController importanceController;
  final String buttonText;
  final Function onSaved;

  const HabitFormWidget(
      {Key key,
      @required this.titleController,
      @required this.subtitleController,
      @required this.importanceController,
      @required this.buttonText,
      @required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: titleController,
          decoration:
              InputDecoration(labelText: 'Title', hintText: 'Drink water'),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: subtitleController,
          decoration: InputDecoration(labelText: 'Note', hintText: '2L'),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: importanceController,
          decoration: InputDecoration(
              labelText: 'How important is this?',
              hintText: 'High | Medium | Low'),
        ),
        ElevatedButton(
            child: Text(buttonText),
            onPressed: () async {
              return onSaved();
            }),
      ],
    );
  }
}
