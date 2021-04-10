import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  Future<void> setFirstRun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_run', false); //it is not first run
  }

  Future<void> setFirstRunTrue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('first_run', true); //It is first run
  }

  Future<bool> isFirstRun() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_run') ?? true; //check value
  }

  Future<void> clearPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('first_run'); // clear prefs
  }

  Future<void> logout({@required Function setStates}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', null);
    setStates(); //set State to false and ''
  }

  Future<void> loginUser({@required setStates, @required String uid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', uid);
    setStates(); //uid to user model uid and is logged to true
    //clear controller
  }
}
