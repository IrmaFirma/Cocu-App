import 'package:flutter/material.dart';

class EmailWidget extends StatelessWidget {
  final Widget MyCardWIdget;
  final Widget MyAvatarWidget;
  final Function onSignIn;
  final String buttonText;

  const EmailWidget(
      {Key key,
      @required this.MyCardWIdget,
      @required this.MyAvatarWidget,
      @required this.onSignIn,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: ListView(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
              padding: EdgeInsets.only(right: width*0.7, top: height/25),
              child: Container(
                height: height/20,
                width: width/20,
                child: Image.asset('assets/arrow.png'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height/10),
            child: Container(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  MyCardWIdget,
                  MyAvatarWidget,
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () => onSignIn(),
            child: Padding(
              padding: const EdgeInsets.only(left: 90, right: 90),
              child: Container(
                  height: width/8,
                  decoration: BoxDecoration(
                    color: Color(0xFFDFF4F6),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(buttonText,
                          style: TextStyle(
                              color: Color(0xFF6E6C6C),
                              fontSize: height/35,
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
