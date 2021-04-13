import 'package:flutter/material.dart';

class BuildUserInfo extends StatelessWidget {
  BuildUserInfo(
      {@required this.todoCount,
      @required this.goalCount,
      @required this.journalCount});

  final String todoCount;
  final String goalCount;
  final String journalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 216,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              SizedBox(width: 17),
              Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 33),
                      child: Container(
                        child: Text(
                          'Journal',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Segoe',
                              fontSize: 28),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 76, right: 38, left: 38),
                      child: Image(
                        image: AssetImage('assets/ellipse_2.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 53,
                      left: 70,
                      child: Column(
                        children: <Widget>[
                          Text(
                            journalCount,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                width: 157,
                decoration: BoxDecoration(
                    color: Color(0xFFFEAF68),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              SizedBox(width: 17),
              Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 42),
                      child: Container(
                        child: Text(
                          'Goals',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Segoe',
                              fontSize: 28),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 76, right: 38, left: 38),
                      child: Image(
                        image: AssetImage('assets/ellipse_3.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 53,
                      left: 70,
                      child: Column(
                        children: <Widget>[
                          Text(
                            goalCount,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                width: 157,
                decoration: BoxDecoration(
                    color: Color(0xFF189AB4),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
              ),
              SizedBox(width: 17),
              Container(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 25, left: 45),
                      child: Container(
                        child: Text(
                          'ToDo',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Segoe',
                              fontSize: 28),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 76, right: 38, left: 38),
                      child: Image(
                        image: AssetImage('assets/ellipse_6.png'),
                      ),
                    ),
                    Positioned(
                      bottom: 53,
                      left: 70,
                      child: Column(
                        children: <Widget>[
                          Text(
                            todoCount,
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
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
      ],
    );
  }
}
