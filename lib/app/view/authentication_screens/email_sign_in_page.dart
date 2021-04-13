import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/authentication_screens/auth_widgets/email_widget.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

import 'auth_widgets/email_avatar.dart';
import 'auth_widgets/email_form_card.dart';

//shared preferences
bool isLogged = false;
String userID = '';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //authentication
  void login({BuildContext context, AuthProvider authProvider}) async {
    try {
      final FormState _formState = _formKey.currentState;
      if (_formState.validate()) {
        await authProvider
            .loginWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text,
                context: context)
            .then((_) async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoPage(),
            ),
          );
          //change instead of in direct onPressed called here
          await SharedPrefs().setUserID(uid: authProvider.userModel.userID);
        });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  //form control
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signInBack.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: EmailWidget(
            buttonText: 'SIGN IN',
            MyAvatarWidget: EmailAvatar(),
            MyCardWIdget: MyCard(
              emailController: emailController,
              passwordController: passwordController,
              formKey: _formKey,
            ),
            onSignIn: () =>
                login(context: context, authProvider: _authProvider),
          ),
        ),
      ),
    );
  }
}
