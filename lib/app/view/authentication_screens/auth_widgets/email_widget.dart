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
    return Container(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, right: 310),
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 36,
                width: 36,
                child: Image.asset('assets/arrow.png'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              alignment: Alignment.center,
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
              padding: const EdgeInsets.only(left: 110, right: 110),
              child: Container(
                  height: 51,
                  decoration: BoxDecoration(color: Color(0xFFDFF4F6)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(buttonText,
                          style: TextStyle(
                              color: Color(0xFF6E6C6C),
                              fontSize: 22,
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
