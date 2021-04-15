import 'package:flutter/material.dart';
class Avatar extends StatelessWidget {
  final String photoURL;

  const Avatar({Key key, this.photoURL}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(photoURL),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
