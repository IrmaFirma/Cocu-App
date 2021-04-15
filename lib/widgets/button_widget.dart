import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function onSaved;
  final String buttonText;

  const ButtonWidget({Key key, this.onSaved, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
    );
  }
}
