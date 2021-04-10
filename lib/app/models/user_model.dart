import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String name;
  String email;
  String userID;

  UserModel({this.email, this.name, this.userID});

  factory UserModel.fromDocument(UserCredential userCredential) {
    return UserModel(
        name: userCredential.user.displayName ?? '',
        email: userCredential.user.email ?? '',
        userID: userCredential.user.uid ?? '');
  }
}
