import 'package:flutter/material.dart';

class BuildUserInfo extends StatelessWidget {
  BuildUserInfo({@required this.todoCount, @required this.goalCount, @required this.journalCount});
  final String todoCount;
  final String goalCount;
  final String journalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15),
              Container(
                height: 127,
                width: 132,
                child: Image.asset('assets/circleAvatar.png'),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 58),
                    child: Text(
                      'Hi there,',
                      style: TextStyle(
                          color: Color(0xFF707070),
                          fontSize: 27,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      'have fun with Cocu',
                      style: TextStyle(
                          color: Color(0xFF707070),
                          fontSize: 21,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20),
          child: Container(
            alignment: Alignment.topLeft,
            child: Text(
              'Your Records',
              style: TextStyle(
                  color: Color(0xFF707070),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Segoe'),
            ),
          ),
        ),
        SizedBox(height: 15),
        Container(
          height: 216,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 17),
              Container(
                child: Column(
                  children: [
                    Text('Journal Count'),
                    Text(journalCount != null ? journalCount : ''),
                  ],
                ),
                width: 157,
                decoration: BoxDecoration(
                    color: Color(0xFFFBC490),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              SizedBox(width: 17),
              Container(
                child: Column(
                  children: [
                    Text('Goal Count'),
                    Text(goalCount != null ? goalCount : ''),
                  ],
                ),
                width: 157,
                decoration: BoxDecoration(
                    color: Color(0xFF189AB4),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              SizedBox(width: 17),
              Container(
                child: Column(
                  children: [
                    Text('Not Completed TODO Count'),
                    Text(todoCount != null ? todoCount : ''),
                  ],
                ),
                width: 157,
                decoration: BoxDecoration(
                    color: Color(0xFFFEAF68),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
            ],
          ),
        ),
        SizedBox(height: 17),
        Container(
          child: Text(
            '\"Opportunities don\'t happen. You create them.\"',
            style: TextStyle(
                color: Color(0xFF707070),
                fontFamily: 'Segoe',
                fontSize: 15),
          ),
        ),
        Container(
          child: Text(
            'Chris Grosser',
            style: TextStyle(
                color: Color(0xFF707070),
                fontFamily: 'Segoe',
                fontSize: 15),
          ),
        ),
      ],
    );
  }
}
