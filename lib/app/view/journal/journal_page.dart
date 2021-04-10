import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/journal_model.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';

import 'package:working_project/app/providers/journal_provider.dart';

import 'package:working_project/app/utils/strings.dart';
import 'package:working_project/app/view/goals_habits/goals_page.dart';
import 'package:working_project/app/view/journal/edit_journal_page.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

import 'add_new_journal_screen.dart';

//TODO Fix Scrolling

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
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

  Future<void> _refreshScreenForChanges() async {
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: false).userModel;
    Provider.of<JournalProvider>(context, listen: false).readJournal(
      userID: userModel.userID,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshScreenForChanges();
  }

  @override
  Widget build(BuildContext context) {
    //refresh every build
    final UserModel userModel =
        Provider.of<AuthProvider>(context, listen: true).userModel;
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
                  'Providers App',
                  style: TextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
              ),
              ListTile(
                title: Text('My Journal',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                title: Text('My todo'),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) => TodoPage(),
                        fullscreenDialog: true)),
              ),
              ListTile(
                title: Text('My goals and habits'),
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
            onRefresh: () => _refreshScreenForChanges(),
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
                              //on Tap call journal provider method and delete
                              await journalProvider.deleteJournal(
                                  userID: userModel.userID,
                                  journalID: journal.journalID);
                              _refreshScreenForChanges();
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
