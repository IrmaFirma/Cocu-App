import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/utils/shared_preferences.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

import 'auth_widgets/email_avatar.dart';
import 'auth_widgets/email_form_card.dart';
import 'auth_widgets/email_widget.dart';

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
              builder: (context) => TodoPage(),
            ),
          );
          await SharedPrefs().loginUser(uid: authProvider.userModel.userID);
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/signInBack.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          child: EmailWidget(
            buttonText: 'REGISTER',
            MyAvatarWidget: EmailAvatar(),
            MyCardWIdget: MyCard(
              emailController: emailController,
              passwordController: passwordController,
              formKey: _formKey,
            ),
            onSignIn: () =>
                register(context: context, authProvider: _authProvider),
          ),
        ),
      ),
    );
  }
}
