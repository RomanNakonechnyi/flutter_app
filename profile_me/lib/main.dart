import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:profile_me/helpers/settings.dart';
import 'package:profile_me/passcodePage.dart';
import 'package:profile_me/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'helpers/strings.dart';
import 'home.dart';
import 'models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sp = await SharedPreferences.getInstance();
  for(var key in sp.getKeys()){
    print(sp.get(key));
  }
  runApp(MyApp(prefs:sp));
}

enum AuthMode { SIGNIN, SINGUP }

class MyApp extends StatelessWidget {
  SharedPreferences prefs;
  MyApp({this.prefs});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      theme: ThemeData(
        primaryColorDark: Colors.blue,
        accentColor: Colors.blue,

      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(prefs:prefs),
        '/signIn':(context) => SignIn(),
        '/home' : (context) => Home()
      }
    );
  }
}

class SplashScreen extends StatefulWidget {
  final SharedPreferences prefs;
  SplashScreen({this.prefs});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool checkIfAnyKeysInStorage(){
    var anyKeys = false;
    anyKeys = widget.prefs.getKeys().length > 0;
    return anyKeys;
  }

  bool checkUserInStorage() {
    bool hasUser = false;
    if(widget.prefs.containsKey(Strings.user)){
      hasUser = widget.prefs.getString(Strings.user) != "";
    }
    return hasUser;
  }

  bool checkIfPasscodeTimeIsValid() {
    bool passcodeIsValid = false;
    if(widget.prefs.containsKey(Strings.lastTimeQuit)){
      passcodeIsValid = (DateTime.now().millisecondsSinceEpoch - widget.prefs.getInt(Strings.lastTimeQuit) )
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
      child: SignIn()
      );

    return loginPage;
  }

  Widget navigateToHomePage(BuildContext context){
    Settings.currentUser = User.fromJson(jsonDecode(widget.prefs.getString(Strings.user)));
    return Home();
  }

  Widget navigatePasscodePage(BuildContext context) {
    return PasscodePage();
  }

  @override
  Widget build(BuildContext context) {
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





