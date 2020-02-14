import 'package:flutter/material.dart';
import 'package:profile_me/models/SynonymModel.dart';
import 'package:profile_me/services/apiService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/settings.dart';
import 'helpers/strings.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<String> synonyms = List<String>();
  final TextEditingController synonymTextController = TextEditingController();

  String notFindText;

  bool firstStart = true;

  @override
  void dispose() {
    synonymTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FlutterLogo(),
        ),
        title: new Text(Settings.currentUser.fullName ),
        elevation: 25,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 40,
          ),
            onPressed: _executeLogOut,
          )
        ],
      ),
    body: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0,bottom: 15),
                child: new TextFormField(
                  controller: synonymTextController,
                  decoration: InputDecoration(
                      labelStyle: TextStyle(letterSpacing: 3),
                      labelText: "Word to find synonyms", floatingLabelBehavior: FloatingLabelBehavior.auto),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: new RaisedButton(onPressed: _fetchData,
                elevation: 5,
                child: Text("search synonyms"),
              ),
            ),
          ],
        ),
        synonyms.length == 0? getLoadingOrErrorWidget()
            : Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: synonyms.length,
              itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  height: 50,
                  color: Colors.deepOrangeAccent,
                  child: Center(
                    child: Text('${synonyms[index]}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white
                      ),
                    )
                  ),
                ),
              );
          }),
              ),
            )
      ],
    ),
    );
  }

  void _executeLogOut() {
    eraseInfo();
    Navigator.pushNamedAndRemoveUntil(
        context,
        '/signIn',
        ModalRoute.withName('/')
    );
  }

  Widget getLoadingOrErrorWidget(){
    if(firstStart){
      return Container();
    }
    if(notFindText == ''){
      return new CircularProgressIndicator(
        backgroundColor: Colors.yellow,
      );
    }else{
      return Text(notFindText);
    }
  }

  void eraseInfo() async{
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Strings.user, '');
    prefs.setInt(Strings.lastTimeQuit, 0);
  }

  void _fetchData() async{

    setState(() {
      firstStart = false;
      synonyms.clear();
      notFindText ='';
    });
    var apiService = await ApiService.getInstance();
    SynonymModel synonym = await apiService.getSynonyms(synonymTextController.text);
    if(synonym != null){
      setState(() {
        synonyms.addAll(synonym.synonyms);
      });
    }else{
      setState(() {
        notFindText = "No synonyms for ${synonymTextController.text} has been founded";
      });
    }
  }
}
