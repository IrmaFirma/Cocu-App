import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/models/user_model.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/category_todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/journal/journal_page.dart';
import 'package:working_project/app/view/todo/add_category.dart';
import 'package:working_project/app/view/todo/todo_widgets/build_category_home_widget.dart';
import 'package:working_project/widgets/drawer_widget.dart';

import '../../utils/shared_preferences.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  //authentication and data fetch functions
  SharedPrefs prefs = SharedPrefs();

  //TODO Instead of reading ToDo's read Categories move this logic to Todo Category List
  Future<void> _getInitialData() async {
    final bool isLogged = await prefs.readIsLogged();
    if (isLogged) {
      final String userID = await prefs.readUserID();
      if (userID.isNotEmpty) {
        Provider.of<CategoryTodoProvider>(context, listen: false).readCategory(
          userID: userID,
        );
      }
    } else {
      final UserModel userModel =
          Provider.of<AuthProvider>(context, listen: false).userModel;
      Provider.of<CategoryTodoProvider>(context, listen: false).readCategory(
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
    precacheImage(const AssetImage('assets/todoBack.png'), context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: const Text(
            'ToDo',
            style: TextStyle(color: Colors.black87),
          ),
          elevation: 0,
          backgroundColor: Color(0xFFFCFCFC),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                final String userID = await prefs.readUserID();
                Navigator.push(
                  context,
                  CupertinoPageRoute<void>(
                    builder: (BuildContext context) {
                      return AddNewCategory(userID: userID);
                    },
                  ),
                );
              },
            ),
          ],
        ),
        drawer: CommonDrawer(
          secondElementTitle: 'ToDo',
          fourthElementTitle: 'Journal',
          secondEFunction: () => print('Already selected'),
          fourthEFunction: () => Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => JournalPage(),
                  fullscreenDialog: true)),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: AssetImage('assets/todoBack.png') != null
                ? DecorationImage(
                    image: AssetImage('assets/todoBack.png'),
                    fit: BoxFit.fill,
                  )
                : null,
          ),
          child: WillPopScope(
            onWillPop: null,
            child: RefreshIndicator(
              onRefresh: () => _getInitialData(),
              child: BuildCategoryHome(
                getInitialData: () async {
                  await _getInitialData();
                },
              ),
            ),
          ),
        ));
  }
}
