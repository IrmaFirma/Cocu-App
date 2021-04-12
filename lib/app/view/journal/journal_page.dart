import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/journal_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/utils/strings.dart';
import 'package:working_project/app/view/goals_habits/goals_page.dart';
import 'package:working_project/app/view/journal/edit_journal_page.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

import '../user_info_page.dart';
import 'add_new_journal_screen.dart';

//TODO Fix Scrolling
//TODO: REFRESH AFTER EDIT
class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  final SharedPrefs prefs = SharedPrefs();

  //new snackbar
  void showSnackBar(BuildContext context, String text, Color color) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: color,
      ),
    );
  }

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
  }

  @override
  Widget build(BuildContext context) {
    //refresh every build
    final List<JournalModel> journals =
        Provider.of<JournalProvider>(context, listen: true).journalModels;
    final JournalProvider journalProvider =
        Provider.of<JournalProvider>(context, listen: true);
    //ui
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.homePage),
          actions: [
            TextButton(
              onPressed: null,
              child: Text('Logout'),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => AddNewJournal(),
                fullscreenDialog: true),
          ),
          child: Icon(Icons.add),
          backgroundColor: Colors.indigo,
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
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomePage(),
                        fullscreenDialog: true)),
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
        body: WillPopScope(
          onWillPop: null,
          child: RefreshIndicator(
            onRefresh: () => _getInitialData(),
            child: ListView(
              children: [
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: journals.length,
                  itemBuilder: (context, int index) {
                    final JournalModel journal = journals[index];
                    //formatting date
                    var date = DateTime.parse(journal.createdDate);
                    var formattedDate =
                        '${date.day}/${date.month}/${date.year}';
                    //slidable widget for delete and edit
                    return ClipRRect(
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        key: Key(journal.journalID.toString()),
                        actions: [
                          IconSlideAction(
                              color: Colors.deepOrangeAccent,
                              //edit function call
                              onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditJournal(
                                        journal: journal,
                                      ),
                                    ),
                                  ),
                              caption: 'Edit',
                              icon: Icons.edit)
                        ],
                        secondaryActions: [
                          IconSlideAction(
                            color: Colors.red,
                            caption: 'Delete',
                            //delete function call
                            onTap: () async {
                              final String userID = await prefs.readUserID();
                              await journalProvider.deleteJournal(
                                  userID: userID, journalID: journal.journalID);
                              _getInitialData();
                              showSnackBar(context, 'Deleted ${journal.title}',
                                  Colors.red);
                            },
                            icon: Icons.delete,
                          )
                        ],
                        child: ListTile(
                          //onTap showing edit page(details)
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditJournal(
                                  journal: journal,
                                ),
                              ),
                            );
                          },
                          title: Text(journal.title,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.indigo)),
                          subtitle: Container(
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(journal.subtitle)),
                                Container(
                                    alignment: Alignment.topLeft,
                                    child: Text('Created: $formattedDate')),
                              ],
                            ),
                          ),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
