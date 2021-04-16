import 'package:flutter/material.dart';
import 'package:working_project/widgets/button_widget.dart';

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
                hintText: 'ToDo Title',
              ),
              maxLength: 25,
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
                hintText: 'Description',
              ),
              maxLines: 7,
            ),
          ),
          TextButton(
            child: Row(
              children: [
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
          ButtonWidget(
            onSaved: () => onSaved(),
            buttonText: buttonText,
          ),
        ],
      ),
    );
  }
}
