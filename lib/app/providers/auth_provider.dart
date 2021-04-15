import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:working_project/app/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    auth = FirebaseAuth.instance;
  }

  FirebaseAuth auth;

  //getting the model object
  UserModel _userModel;

  UserModel get userModel => _userModel ?? UserModel();

  //register user with email and password method
  Future<void> registerWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ooops, error occurred'),
                content: Text('Try again!'),
                actions: [
                  TextButton(
                    child: Text("DISMISS"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
      _userModel = UserModel.fromDocument(userCredential);
      print(_userModel.userID);
      print(_userModel.userID);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  //login user with email and password method
  Future<void> loginWithEmailAndPassword(
      {@required String email,
      @required String password,
      @required BuildContext context}) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .catchError((err) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Ooops, error occurred'),
                content: Text('Try again!'),
                actions: [
                  TextButton(
                    child: Text("DISMISS"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            });
      });
      _userModel = UserModel.fromDocument(userCredential);
      print('This is your id: ${_userModel.userID}');
      print('This is your email: ${_userModel.email}');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  Future<void> signInWithGoogle({@required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final UserCredential userCredential = await auth
            .signInWithCredential(GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken))
            .catchError((err) {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Ooops, error occurred'),
                  content: Text('Try again!'),
                  actions: [
                    TextButton(
                      child: Text("DISMISS"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        });
        _userModel = UserModel.fromDocument(userCredential);
        notifyListeners();
      } else {
        throw PlatformException(
            code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
            message: 'Missing Google Auth Token');
      }
    } else {
      throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user');
    }
  }

  //logout current user
  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
