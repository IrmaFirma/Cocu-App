import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/strings.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

import 'authentication_screens/email_sign_in_page.dart';
import 'authentication_screens/email_sign_up_page.dart';

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
        MaterialPageRoute(
            builder: (context) => RegisterScreen(), fullscreenDialog: true));
  }

  Future<void> _navigateToLoginWithEmail(BuildContext context) {
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginScreen(), fullscreenDialog: true));
  }

  Future<void> signInWithGoogle(
      BuildContext context, AuthProvider authProvider) async {
    try {
      await authProvider.signInWithGoogle(context: context).then(
        (_) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoPage(),
            ),
          );
        },
      );
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: _buildSignIn(context),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 200, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ElevatedButton(
              child: Text('Sign In With Google'),
              onPressed: () => signInWithGoogle(context, _authProvider),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              child: Text('Register with email and password'),
              onPressed: () => _navigateToRegisterWithEmail(context),
            ),
            SizedBox(height: 8),
            Text(
              Strings.or,
              style: TextStyle(fontSize: 14.0, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
              child: TextButton(
                  child: Row(
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        'Sign In',
                        style: TextStyle(color: Colors.indigo),
                      )
                    ],
                  ),
                  onPressed: () {
                    return _navigateToLoginWithEmail(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
