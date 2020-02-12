import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/settings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    if(Settings.currentUser == null){
      
    }
    return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.only(left:50.0,top:150.0,right:50.0,bottom:75.0),
        child: Container(

          child: Text(Settings.currentUser.fullName + Settings.currentUser.login),
           color: Colors.green.withAlpha(50),
        ),
      ),
      ),
    );
  }
}
