import 'package:flutter/material.dart';
import 'package:working_project/app/view/journal/journal_page.dart';
import 'package:working_project/app/view/todo/category_page.dart';

class UserInfoDrawer extends StatelessWidget {
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
              'Home Page',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              'Todo',
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => CategoryPage(),
                  fullscreenDialog: true),
            ),
          ),
          ListTile(
            title: Text('Journal'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => JournalPage(),
                  fullscreenDialog: true),
            ),
          ),
        ],
      ),
    );
  }
}
