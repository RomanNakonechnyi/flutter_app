import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/settings.dart';
import 'helpers/strings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Center(
      child: Padding(
        padding: const EdgeInsets.only(left:50.0,top:150.0,right:50.0,bottom:75.0),
        child: Column(
          children: <Widget>[
            new Text(Settings.currentUser.fullName + Settings.currentUser.login),
            new RaisedButton(onPressed: _executeLogOut),
          ],
        ),
      ),
      ),
    );
  }

  void _executeLogOut() {
    eraseInfo();
    //Navigator.pushNamed(context, '/signIn');
    Navigator.pushNamedAndRemoveUntil(
        context,
        '/signIn',
        ModalRoute.withName('/')
    );
  }

  void eraseInfo() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Strings.user, '');
    prefs.setInt(Strings.lastTimeQuit, 0);
  }
}
