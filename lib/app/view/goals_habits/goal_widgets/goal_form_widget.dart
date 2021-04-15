import 'package:flutter/material.dart';
import 'package:working_project/widgets/button_widget.dart';

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
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1),
                ),
                hintText: 'Goal Title',
              ),
              maxLength: 25,
            ),
          ),
          TextButton(
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    'Due',
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Icon(Icons.calendar_today_sharp,
                      color: Color(0xFFF67B50)),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  dateText,
                  style: TextStyle(
                      fontFamily: 'Varela',
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            onPressed: () {
              return dateFunc();
            },
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
