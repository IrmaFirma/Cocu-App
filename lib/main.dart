import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'package:working_project/app/view/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogged = false;
  String userID = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin();
  }

  Future<void> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userId =  prefs.getString('userID');
    if (userId != null) {
      setState(() {
        isLogged = true;
        userID = userId;
      });
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (BuildContext context) => AuthProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => TodoProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => GoalProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => JournalProvider()),
          ChangeNotifierProvider(
              create: (BuildContext context) => HabitProvider()),
        ],
        child: MaterialApp(
          home: isLogged
              ? TodoPage()
              : WelcomePageBuilder(), //Replace with RootPage
        ));
  }
}