import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final String login = "roma";
  final String password = "123456";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final loginTextController = new TextEditingController();
  final passwordTextController = new TextEditingController();
  double screenHeight;
  @override
  void dispose() {
    loginTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          children: <Widget>[
            lowerBackgroundImage(context),
            loginCard(context)
          ],
        ),
      ),
    );
  }

  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Card(
            color: Color(0xFFFFFFFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 30,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: loginTextController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: "Your Email", floatingLabelBehavior: FloatingLabelBehavior.auto),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passwordTextController,
                    decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        labelText: "Password", floatingLabelBehavior: FloatingLabelBehavior.auto),
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        child: Text("Forgot Password ?",
                          style: TextStyle(color: Colors.black,
                          fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      RaisedButton(
                        elevation: 12,
                        hoverElevation: 0,
                        child: Text("Login",
                          style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 18),),
                        color: Colors.green,
                        textColor: Colors.white,
                        padding: EdgeInsets.only(
                            left: 38, right: 38, top: 15, bottom: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          return showDialog(context: context,
                          builder: (context){
                            return AlertDialog(
                              content: Text(loginTextController.text + " " + passwordTextController.text ),
                            );
                          });
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.white),
            ),
            FlatButton(
              onPressed: () {

              },
              textColor: Colors.white,
              child: Text("Create Account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2
                ),),
            )
          ],
        )
      ],
    );
  }

  Widget lowerBackgroundImage(BuildContext context) {
    return Container(
      height: screenHeight,
      child: Image.asset('assets/images/man_on_bridge.jpg',
          filterQuality: FilterQuality.high,
          fit: BoxFit.cover),
    );
  }
}