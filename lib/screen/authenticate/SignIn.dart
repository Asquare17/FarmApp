import 'package:farm_app1/service/auth.dart';
import 'package:farm_app1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/Models/user.dart';
import 'package:farm_app1/screen/home/home.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool _obscureText = true;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user1 = Provider.of<User>(context);
    return StreamBuilder<User>(
        stream: AuthService().user,
        builder: (context, user) {
          if (user1 == null && loading == false) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.lightGreen,
                actions: <Widget>[],
                title: Text('Sign In'),
              ),
              body: Center(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(15.0),
                  children: <Widget>[
                    Center(
                      child: Card(
                        elevation: 8.0,
                        child: Container(
                          padding: EdgeInsets.all(10.0),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Please Enter E-mail';
                                    } else if (RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val)) {
                                      return null;
                                    } else {
                                      return 'Enter a valid E-mail';
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    labelText: "Email",
                                  ),
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                TextFormField(
                                    validator: (val) {
                                      if (val.isEmpty) {
                                        return 'Please enter your password';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (val) {
                                      setState(() => password = val);
                                    },
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      prefixIcon: Icon(Icons.lock),
                                      suffixIcon: IconButton(
                                          icon: Icon(_obscureText
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onPressed: () {
                                            setState(() =>
                                                _obscureText = !_obscureText);
                                          }),
                                    )),
                                SizedBox(
                                  height: 15.0,
                                ),
                                Material(
                                  borderRadius: BorderRadius.circular(30.0),
                                  elevation: 5.0,
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        setState(() => loading = true);
                                        dynamic result = await _auth
                                            .signInWithEmailAndPassword(
                                                email, password);
                                        if (result == null) {
                                          setState(() => loading = false);
                                          setState(() => error =
                                              'Wrong password or email, could not sign in');
                                        }
                                        if (result != null) {
                                          setState(() => loading = false);
                                        }
                                      }
                                    },
                                    minWidth: 150.0,
                                    height: 50.0,
                                    color: Colors.lightGreen[700],
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(child: Text("Don't Have a Account?")),
                        FlatButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, '/register');
                          },
                          child: Text("Sign Up",
                              style: TextStyle(
                                color: Colors.lightGreen,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
              // bottomNavigationBar: Padding(
              //   padding: EdgeInsets.all(10.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: <Widget>[
              //       Expanded(
              //         child: RaisedButton(
              //             padding: EdgeInsets.all(15.0),
              //             onPressed: () async {
              //               dynamic result = await _auth.signInAnon();
              //               result == null
              //                   ? print('error signing in')
              //                   : print('signIn');
              //             },
              //             color: Colors.white,
              //             shape: RoundedRectangleBorder(
              //                 borderRadius: BorderRadius.circular(
              //                   15.0,
              //                 ),
              //                 side: BorderSide(color: Colors.lightGreen)),
              //             child: Text(
              //               "SIGN IN AS GUEST",
              //               style: TextStyle(
              //                   fontSize: 18.0, color: Colors.lightGreen),
              //             )),
              //       )
              //     ],
              //   ),
              // ),
            );
          } else if (user1 == null && loading == true) {
            return Loading();
          } else {
            return Home();
          }
        });
  }
}
