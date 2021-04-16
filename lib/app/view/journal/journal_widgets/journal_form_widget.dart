import 'package:flutter/material.dart';
import 'package:working_project/widgets/button_widget.dart';

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
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
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
                hintText: 'Title',
              ),
              maxLength: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: TextFormField(
              controller: subtitleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'Subtitle',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'Journaling opens the door of our hearts.',
              ),
              maxLines: 15,
            ),
          ),
          SizedBox(
            height: 10,
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
