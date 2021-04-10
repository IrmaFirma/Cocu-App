import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_project/app/providers/auth_provider.dart';
import 'package:working_project/app/view/todo/todo_page.dart';

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
        (_) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TodoPage(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider _authProvider =
        Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Register with Email and Password'),
      ),
      body: Container(
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'Email', hintText: 'cocu@cocu.com'),
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  ElevatedButton(
                      child: Text('Register'),
                      onPressed: () {
                        return register(
                            context: context, authProvider: _authProvider);
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
