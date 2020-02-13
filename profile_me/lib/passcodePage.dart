import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:profile_me/helpers/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/strings.dart';
import 'models/user.dart';

class PasscodePage extends StatelessWidget {
  static final int allowedAttempts = 2;
  int _attemptsMade = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextField(
          decoration: InputDecoration(
            labelText: "Enter passcode",
            floatingLabelBehavior: FloatingLabelBehavior.auto
          ),
          onChanged: (value) async{
            if(value.length == 4){
              if(_attemptsMade >= allowedAttempts){
                  Navigator.pushNamed(context, '/signIn');
                  return;
              }
              if(await checkIfPasscodeValid(value)){
                Navigator.pushReplacementNamed(context, '/home');
                return;
              }
            }
          },
        ),
      ),
    );
  }

  Future<bool> checkIfPasscodeValid(String value) async{
    print("here");
    _attemptsMade += 1;
    bool isValid = false;
    var passcode = int.parse(value);
    var prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(Strings.passcode)){
      isValid = passcode == prefs.getInt(Strings.passcode);
    }

    isValid = passcode == 1111;
    Settings.currentUser = User.fromJson(jsonDecode(prefs.getString(Strings.user)));
    return isValid;
  }

  void eraseDate() {}
}
