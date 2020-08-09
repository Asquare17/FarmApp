import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                      padding: EdgeInsets.all(15.0),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            15.0,
                          ),
                          side: BorderSide(color: Colors.lightGreen)),
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.lightGreen,
                        ),
                      )),
                )
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(child: Text("Already have an account?")),
              FlatButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/signIn',
                  );
                },
                child: Text("Sign In",
                    style: TextStyle(
                      color: Colors.lightGreen,
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
