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
          GestureDetector(
            onTap: () => onSaved(),
            child: Padding(
              padding: const EdgeInsets.only(left: 130, right: 130),
              child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF189AB4),
                    borderRadius: BorderRadius.all(Radius.circular(7)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(buttonText,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Raleway')),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
