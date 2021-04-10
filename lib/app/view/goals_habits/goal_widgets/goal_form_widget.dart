import 'package:flutter/material.dart';

class GoalFormWidget extends StatelessWidget {
  final String dateText;
  final String buttonText;
  final TextEditingController controller;
  final Function dateFunc;
  final Function onSaved;

  const GoalFormWidget(
      {Key key,
      @required this.dateText,
      @required this.buttonText,
      @required this.controller,
      @required this.dateFunc,
      @required this.onSaved})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
          child: Text(dateText),
          onPressed: () async {
            return dateFunc();
          }),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: 'Goal title', hintText: 'Be healthy and happy!'),
      ),
      SizedBox(height: 15),
      ElevatedButton(
          child: Text(buttonText),
          onPressed: () async {
            return onSaved();
          }),
    ]);
  }
}
