import 'package:flutter/material.dart';

Container EmailAvatar() {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/email.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}
