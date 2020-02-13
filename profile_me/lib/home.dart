import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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
            new RaisedButton(onPressed: _executeLogOut,
            child: Text("LOG OUT"),
            ),
            new RaisedButton(onPressed: _fetchData,
              child: Text("LOG OUT"),
            ),
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

  void _fetchData() async{
    var client = http.Client();
    try {
      http.Response response = await client.get(
          "https://wordsapiv1.p.rapidapi.com/words/birthday",
          headers: {
            'x-rapidapi-host':'wordsapiv1.p.rapidapi.com',
            'x-rapidapi-key':'<YOUR_API_KEY_FROM_RAPID_API>'
          }
      );

      print(response.body);
    }finally{
      client.close();
    }
  }
}
