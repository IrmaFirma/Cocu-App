import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/welcome_page.dart';

bool isLogged = false;
String userID = '';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Future<void> _signOut(BuildContext context) async {
    try {
      final AuthProvider auth =
          Provider.of<AuthProvider>(context, listen: false);
      await auth.logout().then((_) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePageBuilder())));
      await SharedPrefs().logout(setStates: () {
        setState(() {
          isLogged = false;
          userID = auth.userModel.userID;
        });
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user =
        Provider.of<AuthProvider>(context, listen: true).userModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color(0xFFc28285),
        actions: <Widget>[
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: () async {
               _signOut(context);
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130.0),
          child: _buildUserInfo(user),
        ),
      ),
    );
  }

  Widget _buildUserInfo(UserModel user) {
    return Column(
      children: [
        SizedBox(height: 8),
        if (user.name != null)
          Text(
            user.name,
            style: TextStyle(color: Colors.white),
          ),
        SizedBox(height: 8),
      ],
    );
  }
}
