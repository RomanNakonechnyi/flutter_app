import 'package:flutter/material.dart';
import 'package:profile_me/home.dart';
import 'package:profile_me/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/strings.dart';


class PasscodePage extends StatelessWidget {
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
              if(await checkIfPasscodeValid(value)){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> Home()));
              }
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> SignIn()));
            }
          },
        ),
      ),
    );
  }

  Future<bool> checkIfPasscodeValid(String value) async{
    print(value);
    bool isValid = false;
    var passcode = int.parse(value);
    var prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey(Strings.passcode)){
      isValid = passcode == prefs.getInt(Strings.passcode);
    }
    isValid = passcode == 1111;
    print(isValid);
    return isValid;
  }
}
