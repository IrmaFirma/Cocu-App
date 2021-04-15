import 'package:flutter/material.dart';
import 'package:working_project/widgets/button_widget.dart';

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
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'Habit Title',
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
                hintText: 'Note',
              ),
              maxLines: 7,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
            child: TextFormField(
              controller: importanceController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'How important is this?',
              ),
              maxLines: 4,
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
