import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 342,
        height: 199,
        margin: EdgeInsets.all(40.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 45,
                    ),
                    Text(
                      'Ooops, error occurred',
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21,
                          color: Color(0xFF2E2D2D)),
                    ),
                    Text(
                      'Try again',
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2E2D2D),
                          fontFamily: 'Valera'),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'DISMISS',
                        style: TextStyle(fontFamily: 'Valera', fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
