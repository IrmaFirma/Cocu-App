import 'package:flutter/material.dart';

class BuildUserInfo extends StatelessWidget {
  BuildUserInfo(
      {@required this.todoCount,
      @required this.journalCount});

  final String todoCount;
  final String journalCount;

  //TODO: DECORATE OTHERS
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
                width: 157,
                child: Card(
                  color: Color(0xFFF67B50),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
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
                        bottom: 47,
                        left: 68,
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
                  elevation: 2,
                ),
              ),
              SizedBox(width: 17),
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
