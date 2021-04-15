import 'package:flutter/material.dart';
import 'package:working_project/app/view/goals_habits/goals_page.dart';
import 'package:working_project/app/view/journal/journal_page.dart';
import 'package:working_project/app/view/user_info_page.dart';

class TodoDrawer extends StatelessWidget {
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
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => UserInfoPage(),
                    fullscreenDialog: true)),
          ),
          ListTile(
            title: Text(
              'Todo',
            ),
          ),
          ListTile(
            title: Text('Journal'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => JournalPage(),
                    fullscreenDialog: true)),
          ),
          ListTile(
            title: Text('Goals and Habits'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => GoalPage(),
                    fullscreenDialog: true)),
          ),
        ],
      ),
    );
  }
}
