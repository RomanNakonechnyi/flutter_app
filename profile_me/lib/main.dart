import 'package:flutter/material.dart';
import 'package:profile_me/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() => runApp(MyApp());

enum AuthMode { SIGNIN, SINGUP }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child:  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    ),
    );
  }
}







