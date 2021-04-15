import 'package:flutter/material.dart';

class CommonDrawer extends StatelessWidget {
  final String firstElementTitle;
  final String thirdElementTitle;
  final String secondElementTitle;
  final String fourthElementTitle;
  final Function firstEFunction;
  final Function secondEFunction;
  final Function thirdEFunction;
  final Function fourthEFunction;

  const CommonDrawer(
      {Key key,
      this.firstElementTitle,
      this.thirdElementTitle,
      this.secondElementTitle,
      this.fourthElementTitle,
      this.firstEFunction,
      this.secondEFunction,
      this.thirdEFunction,
      this.fourthEFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Cocu',
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          ListTile(
            title: Text(
              firstElementTitle,
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            onTap: () => firstEFunction(),
          ),
          ListTile(
            title: Text(
              secondElementTitle,
            ),
            onTap: () => secondEFunction(),
          ),
          ListTile(
            title: Text(thirdElementTitle),
            onTap: () => thirdEFunction(),
          ),
          ListTile(
            title: Text(fourthElementTitle),
            onTap: () => fourthEFunction(),
          ),
        ],
      ),
    );
  }
}
