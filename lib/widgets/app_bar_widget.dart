import 'package:flutter/material.dart';

AppBar commonAppBar({@required String barText, @required Function addNew}) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.black87),
    title: Text(barText, style: TextStyle(color: Colors.black87)),
    elevation: 0,
    backgroundColor: Color(0xFFFCFCFC),
    actions: [
      TextButton(
          onPressed: () => addNew(),
          child: Icon(
            Icons.add,
            color: Colors.black87,
          ))
    ],
  );
}
