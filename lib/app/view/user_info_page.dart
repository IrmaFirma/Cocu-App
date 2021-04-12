import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'package:working_project/app/view/welcome_page.dart';

import 'goals_habits/goals_page.dart';
import 'journal/journal_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _signOut(BuildContext context) async {
    try {
      await SharedPrefs().setIsLoggedFalse();
      await SharedPrefs().logout();
      final AuthProvider auth =
          Provider.of<AuthProvider>(context, listen: false);
      await auth.logout().then((_) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePageBuilder())));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _signOut(context),
      ),
      drawer: Drawer(
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
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text(
                'Todo',
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                      builder: (BuildContext context) => TodoPage(),
                      fullscreenDialog: true)),
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
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 127,
                    width: 132,
                    child: Image.asset('assets/circleAvatar.png'),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 58),
                        child: Text(
                          'Hi there,',
                          style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 27,
                              fontFamily: 'Segoe',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'have fun with Cocu',
                          style: TextStyle(
                              color: Color(0xFF707070),
                              fontSize: 21,
                              fontFamily: 'Segoe',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 16),
              child: Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Your Records',
                  style: TextStyle(
                      color: Color(0xFF707070),
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Segoe'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
