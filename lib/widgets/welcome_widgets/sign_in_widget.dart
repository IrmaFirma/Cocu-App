import 'package:flutter/material.dart';

class BuildSignIn extends StatelessWidget {
  final Function onGoogle;
  final Function onRegister;
  final Function onSignIn;

  const BuildSignIn(
      {Key key,
      @required this.onGoogle,
      @required this.onRegister,
      @required this.onSignIn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Column(
            children: [
              Text(
                'Welcome to Cocu',
                style: TextStyle(
                    color: Color(0xFF505050),
                    fontSize: 30,
                    fontFamily: 'Segoe'),
              ),
              Text(
                'Choose your next step',
                style: TextStyle(
                    color: Color(0xFF6E6C6C),
                    fontFamily: 'Segoe',
                    fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: GestureDetector(
              onTap: () => onGoogle(),
              child: Container(
                  height: 51,
                  decoration: BoxDecoration(color: Color(0xFFDFF4F6)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/google.png'),
                            height: 45,
                            width: 45,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Get started with Google',
                              style: TextStyle(
                                  color: Color(0xFF6E6C6C),
                                  fontSize: 17,
                                  fontFamily: 'Segoe')),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: GestureDetector(
              onTap: () => onRegister(),
              child: Container(
                  height: 51,
                  decoration: BoxDecoration(color: Color(0xFFDFF4F6)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 15),
                            child: Image.asset('assets/email.png'),
                            height: 50,
                            width: 50,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text('Get started with Email',
                              style: TextStyle(
                                  color: Color(0xFF6E6C6C),
                                  fontSize: 17,
                                  fontFamily: 'Segoe')),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          TextButton(
            onPressed: () => onSignIn(),
            child: Text(
              'Already have an account? Sign In',
              style: TextStyle(color: Color(0xFF505050), fontFamily: 'Segoe'),
            ),
          ),
        ],
      ),
    );
  }
}
