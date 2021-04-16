import 'dart:async';

import 'package:flutter/material.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'package:working_project/app/view/welcome_page.dart';

class CocuSplash extends StatefulWidget {
  @override
  _CocuSplashState createState() => _CocuSplashState();
}

class _CocuSplashState extends State<CocuSplash> {
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
    Timer(
      Duration(seconds: 3),
      () => isLogged
          ? Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => TodoPage()))
          : Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WelcomePageBuilder(),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/cocuBack.png'), context);
    return Container(
      decoration: BoxDecoration(
          image: AssetImage('assets/cocuBack.png') != null
              ? DecorationImage(
                  image: const AssetImage('assets/cocuBack.png'),
                  fit: BoxFit.cover)
              : null),
    );
  }
}
