import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/providers/goal_provider.dart';
import 'package:working_project/app/providers/habits_provider.dart';
import 'package:working_project/app/providers/journal_provider.dart';
import 'package:working_project/app/providers/todo_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';

import 'app/view/todo/todo_page.dart';
import 'app/view/welcome_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

//TODO QUERY TOUCH UPS
//TODO RENAME APP FILES AND NAMES
//TODO REFACTOR DESIGN AND LOGIC
//TODO GOAL MAKEOVER
//TODO JOURNAL MAKEOVER
//TODO HABIT MAKEOVER
//TODO HOME MAKEOVER
//TODO SIGN IN SIGN UP TOUCH UP
//TODO PAGE ANOTHER CALENDAR STYLE, LIST TODO FRESH UP
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogged = false;

  SharedPrefs sharedPrefs = SharedPrefs();

  Future<void> autoLogin() async {
    final String userId = await sharedPrefs.readUserID();
    if (userId.isNotEmpty) {
      sharedPrefs.setIsLoggedTrue();
      isLogged = await sharedPrefs.readIsLogged();
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    autoLogin().then((_) => setState(() {}));
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
        home: SplashScreen(
            seconds: 3,
            navigateAfterSeconds: isLogged
                ? TodoPage()
                :  WelcomePageBuilder(),
            image: Image.asset('assets/cocuBack.png'),
            backgroundColor: Color(0xFF6FCED5),
            styleTextUnderTheLoader: new TextStyle(),
            photoSize: 200.0,
            loaderColor: Colors.white),
      ),
    );
  }
}
