import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/todo_page.dart';
import 'file:///C:/Users/F-IRMA/AndroidStudioProjects/CocuApp/lib/app/view/authentication_screens/auth_widgets/auth_form_widget.dart';

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
      resizeToAvoidBottomInset: true,
      body: Container(
        child: Container(
          child: AuthFormWidget(
            formKey: _formKey,
            emailController: emailController,
            passwordController: passwordController,
            buttonText: 'SIGN IN',
            mainMessage: 'Sign In',
            oppositeMessage: 'Don\'t have an account? Create one',
            onSaved: () => login(context: context, authProvider: _authProvider),
          ),
        ),
      ),
    );
  }
}
