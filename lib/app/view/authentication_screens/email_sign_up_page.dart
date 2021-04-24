import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/category_page.dart';

import 'file:///C:/Users/F-IRMA/AndroidStudioProjects/CocuApp/lib/app/view/authentication_screens/auth_widgets/auth_form_widget.dart';

class RegisterScreen extends StatelessWidget {
  //form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void register({BuildContext context, AuthProvider authProvider}) {
    final FormState _formState = _formKey.currentState;
    if (_formState.validate()) {
      authProvider
          .registerWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
              context: context)
          .then(
        (_) async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CategoryPage(),
            ),
          );
          await SharedPrefs().setUserID(uid: authProvider.userModel.userID);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Container(
          child: AuthFormWidget(
            formKey: _formKey,
            emailController: emailController,
            passwordController: passwordController,
            buttonText: 'SIGN UP',
            mainMessage: 'Sign Up',
            oppositeMessage: 'Already have an account? Sign In',
            onSaved: () =>
                register(context: context, authProvider: _authProvider),
          ),
        ),
      ),
    );
  }
}
