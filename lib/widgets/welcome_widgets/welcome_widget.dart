import 'package:flutter/material.dart';

class BuildWelcome extends StatelessWidget {
  final Function onGoogle;
  final Function onRegister;
  final Function onSignIn;

  const BuildWelcome(
      {Key key,
      @required this.onGoogle,
      @required this.onRegister,
      @required this.onSignIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: width / 7, right: width / 7),
      child: Container(
        child: Column(
          children: [
            Text(
              'Welcome to Cocu',
              style: TextStyle(
                  color: Color(0xFF505050),
                  fontSize: height / 25,
                  fontFamily: 'Segoe'),
            ),
            Text(
              'Choose your next step',
              style: TextStyle(
                  color: Color(0xFF6E6C6C),
                  fontFamily: 'Segoe',
                  fontSize: height / 40),
            ),
            SizedBox(
              height: height / 30,
            ),
            GestureDetector(
              onTap: () => onGoogle(),
              child: Container(
                  height: width / 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF6FCED5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
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
                      Row(
                        children: [
                          Container(
                            child: Text(''), //TODO GOOGLE ICON
                            height: height / 16,
                            width: width / 16,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Get started with Google',
                              style: TextStyle(
                                  color: Color(0xFFf7f5f5),
                                  fontSize: height / 45,
                                  fontFamily: 'Segoe')),
                        ],
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: height / 45,
            ),
            GestureDetector(
              onTap: () => onRegister(),
              child: Container(
                  height: width / 8,
                  decoration: BoxDecoration(
                    color: Color(0xFF6FCED5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
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
                      Row(
                        children: [
                          Container(
                            child: Text(''),
                            //TODO EMAIL ICON SAME SIZE AS GOOGLE
                            height: height / 16,
                            width: width / 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Get started with Email',
                              style: TextStyle(
                                  color: Color(0xFFf7f5f5),
                                  fontSize: height / 45,
                                  fontFamily: 'Segoe')),
                        ],
                      ),
                    ],
                  )),
            ),
            Container(
              child: TextButton(
                onPressed: () => onSignIn(),
                child: Container(
                  child: Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                        color: Color(0xFF505050),
                        fontFamily: 'Segoe',
                        fontSize: height / 55),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
