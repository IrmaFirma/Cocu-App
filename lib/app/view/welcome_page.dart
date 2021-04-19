import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/authentication_screens/email_sign_in_page.dart';
import 'package:working_project/app/view/authentication_screens/email_sign_up_page.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'package:working_project/widgets/welcome_widgets/sign_in_widget.dart';

class WelcomePageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}

class WelcomePage extends StatelessWidget {
  Future<void> _navigateToRegisterWithEmail(BuildContext context) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => RegisterScreen(), fullscreenDialog: true));
  }

  Future<void> _navigateToLoginWithEmail(BuildContext context) {
    return Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => LoginScreen(), fullscreenDialog: true));
  }

  Future<void> signInWithGoogle(
      BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.signInWithGoogle(context: context).then(
        (_) async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoPage(),
            ),
          );
          await SharedPrefs().setUserID(uid: authProvider.userModel.userID);
        },
      );
    } on FirebaseException catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/welcomeBackk.jpg'), context);
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    //media query height
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.grey[200],
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: const AssetImage('assets/welcomeBackk.jpg'),
            fit: BoxFit.fill,
          )),
          child: Container(
            padding: EdgeInsets.only(top: height * 0.55),
              child: BuildWelcome(
                onSignIn: () => _navigateToLoginWithEmail(context),
                onGoogle: () => signInWithGoogle(context, _authProvider),
                onRegister: () => _navigateToRegisterWithEmail(context),
              ))),
    );
  }
}
