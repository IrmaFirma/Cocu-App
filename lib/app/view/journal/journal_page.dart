import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/goals_habits/goals_page.dart';
import 'package:working_project/app/view/journal/journal_widgets/build_journal_widget.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'package:working_project/widgets/app_bar_widget.dart';
import 'package:working_project/widgets/drawer_widget.dart';

import '../user_info_page.dart';
import 'add_new_journal_screen.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final SharedPrefs prefs = SharedPrefs();

  AssetImage journalBack;

  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<JournalProvider>(context, listen: false).readJournal(
          userID: userID,
        );
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<JournalProvider>(context, listen: false).readJournal(
        userID: userModel.userID,
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getInitialData();
    journalBack = AssetImage('assets/todoBack.png');
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(journalBack, context);
  }

  @override
  Widget build(BuildContext context) {
    //ui
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: commonAppBar(
          barText: 'Journal Station',
          addNew: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => AddNewJournal(),
            ),
          ),
        ),
        drawer: CommonDrawer(
            firstElementTitle: 'Home Page',
            secondElementTitle: 'ToDo',
            thirdElementTitle: 'Goals and Habits',
            fourthElementTitle: 'Journal',
            firstEFunction: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => UserInfoPage(),
                    fullscreenDialog: true)),
            secondEFunction: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => TodoPage(),
                    fullscreenDialog: true)),
            thirdEFunction: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => GoalPage(),
                    fullscreenDialog: true)),
            fourthEFunction: null),
        body: Container(
          decoration: BoxDecoration(
            image: journalBack != null
                ? DecorationImage(
                    image: journalBack,
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: WillPopScope(
            onWillPop: null,
            child: RefreshIndicator(
              onRefresh: () => _getInitialData(),
              child: BuildJournal(
                getInitialData: () async {
                  await _getInitialData();
                },
              ),
            ),
          ),
        ));
  }
}
