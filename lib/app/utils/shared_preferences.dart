import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {


  // call on logout
  Future<void> setIsLoggedFalse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', false); //it is not first run
  }

  // if user is logged || if user id is not empty set this to true
  Future<void> setIsLoggedTrue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLogged', true); //It is first run
  }

  Future<bool> readIsLogged() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLogged') ?? true; //check value
  }

  Future<void> clearPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLogged'); // clear prefs
    await prefs.remove('userID');
  }

  Future<void> logout({@required Function setStates}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', '');
  }

  Future<void> loginUser({@required setStates, @required String uid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', uid);
    //clear controller
  }

  Future<String> readUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userID') ?? '';
  }
}
