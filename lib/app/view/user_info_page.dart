import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/journal_model.dart';
import 'package:working_project/app/models/todo_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/welcome_page.dart';
import 'package:working_project/widgets/user_info_widgets/user_info_drawer_widget.dart';
import 'package:working_project/widgets/user_info_widgets/user_info_widget.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  SharedPrefs prefs = SharedPrefs();

  //authentication method
  Future<void> _signOut(BuildContext context) async {
    try {
      await SharedPrefs().setIsLoggedFalse();
      await SharedPrefs().setEmptyUserID();
      final AuthProvider auth =
          Provider.of<AuthProvider>(context, listen: false);
      await auth.logout().then((_) => Navigator.push(context,
          MaterialPageRoute(builder: (context) => WelcomePageBuilder())));
    } catch (e) {
      print(e);
    }
  }



  //getting JournalCount live
  Future<void> _getJournalCount() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<JournalProvider>(context, listen: false)
            .readJournal(userID: userID);
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<JournalProvider>(context, listen: false)
          .readJournal(userID: userModel.userID);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getJournalCount();
  }

  //ui
  @override
  Widget build(BuildContext context) {
    // journals count
    final List<JournalModel> journals =
        Provider.of<JournalProvider>(context, listen: true).journalModels;
    //todos count
    final List<TodoModel> todos =
        Provider.of<TodoProvider>(context, listen: true).todoModels;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black87),
        actions: [
          TextButton(
            onPressed: () => _signOut(context),
            child: Icon(
              Icons.logout,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      drawer: UserInfoDrawer(),
      body: Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/userBack.png'),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: BuildUserInfo(
                todoCount: todos.length.toString(),
                journalCount: journals.length.toString(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
