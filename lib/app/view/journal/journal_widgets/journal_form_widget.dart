import 'package:flutter/material.dart';

class JournalFormWidget extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController subtitleController;
  final TextEditingController descriptionController;
  final String buttonText;
  final Function onSaved;

  const JournalFormWidget(
      {Key key,
      @required this.titleController,
      @required this.subtitleController,
      @required this.descriptionController,
      @required this.onSaved,
      @required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: titleController,
          decoration:
              InputDecoration(labelText: 'Title', hintText: 'Best trip to NYC'),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: subtitleController,
          decoration: InputDecoration(
              labelText: 'Subtitle', hintText: 'Great adventure'),
        ),
        SizedBox(height: 15),
        TextFormField(
          controller: descriptionController,
          decoration:
              InputDecoration(labelText: 'Description', hintText: '...'),
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
