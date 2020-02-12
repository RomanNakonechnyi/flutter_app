import 'dart:math';

import 'package:flutter/material.dart';
import 'package:profile_me/helpers/settings.dart';
import 'package:profile_me/passcodePage.dart';
import 'package:profile_me/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'helpers/strings.dart';
import 'home.dart';
void main() => runApp(MyApp());
//Future<Null> main() async {
//  WidgetsFlutterBinding.ensureInitialized();
//  LocalStorageService._preferences = await SharedPreferences.getInstance();
//  print(LocalStorageService._preferences);
//
//
//  runApp(new MyApp());
//}

enum AuthMode { SIGNIN, SINGUP }
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      home:SplashScreen()
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {

    LocalStorageService.getInstance();


    super.initState();
  }

  bool checkIfAnyKeysInStorage(){
    var anyKeys = false;
    print(LocalStorageService._preferences);
    anyKeys = LocalStorageService._preferences.getKeys().length > 0;
    return anyKeys;
  }

  bool checkUserInStorage() {
    bool hasUser = false;
    if(LocalStorageService._preferences.containsKey(Strings.user)){
      hasUser = LocalStorageService._preferences.getString(Strings.user) != "";
    }
    return hasUser;
  }

  bool checkIfPasscodeTimeIsValid() {
    bool passcodeIsValid = false;
    if(LocalStorageService._preferences.containsKey(Strings.lastTimeQuit)){
      passcodeIsValid = (DateTime.now().millisecondsSinceEpoch - LocalStorageService._preferences.getInt(Strings.lastTimeQuit) )
          < Settings.allowedRelogTimeWithoutPassCodeMilliseconds;
    }
    return passcodeIsValid;
  }

  Widget navigateToLoginPage(BuildContext context) {
    var loginPage = GestureDetector(
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

    return loginPage;
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context)=> SignIn()));
  }

  Widget navigateToHomePage(BuildContext context){
    var homePage = MaterialApp(
      home: Home(),
    );
    return homePage;
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=> Home()));
  }

  Widget navigatePasscodePage(BuildContext context) {
    var passcodePage = MaterialApp(
      home: PasscodePage(),
    );
return passcodePage;
//    Navigator.push(
//        context,
//        MaterialPageRoute(builder: (context)=> PasscodePage()));
  }

  @override
  Widget build(BuildContext context) {

    print(LocalStorageService._preferences);
    bool keysIsPresent = checkIfAnyKeysInStorage();

    if(!keysIsPresent){
      return navigateToLoginPage(context);
    }

    bool isUserInStorage = checkUserInStorage();
    if(!isUserInStorage){
      return navigateToLoginPage(context);
    }

    bool allowWithoutPasscode = checkIfPasscodeTimeIsValid();
    if(allowWithoutPasscode){
      return navigateToHomePage(context);
    }else{
      return navigatePasscodePage(context);
    }
  }
}

class LocalStorageService {
  static LocalStorageService _instance;
  static SharedPreferences _preferences;

  static Future<LocalStorageService> getInstance() async {
    if (_instance == null) {
      _instance = LocalStorageService();
    }

    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }

    return _instance;
  }
}





