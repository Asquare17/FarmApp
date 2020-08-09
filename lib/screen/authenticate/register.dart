import 'package:farm_app1/service/auth.dart';
import 'package:farm_app1/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/Models/user.dart';
import 'package:farm_app1/screen/home/home.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formkey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String error = '';
  bool loading = false;
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final user1 = Provider.of<User>(context);
    return loading
        ? Loading()
        : StreamBuilder<User>(
            stream: AuthService().user,
            builder: (context, user) {
              if (user1 == null) {
                return Scaffold(
                  appBar: AppBar(
                    backgroundColor: Colors.lightGreen,
                    actions: <Widget>[],
                    title: Text('Sign Up'),
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
                                        } else if (val.length < 8) {
                                          return 'Password must be atleast 8 charater';
                                        } else if (!RegExp(r'^(?=.*?[0-9])')
                                            .hasMatch(val)) {
                                          return 'Password must contain at least one digit';
                                        } else if (!RegExp(r'^(?=.*?[A-Z])')
                                            .hasMatch(val)) {
                                          return 'Password must contain at least one UPPER case';
                                        } else if (!RegExp(r'^(?=.*?[a-z])')
                                            .hasMatch(val)) {
                                          return 'Password must contain at least one lower case';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (val) {
                                        setState(() => password = val);
                                      },
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        labelText: "Password",
                                        suffixIcon: IconButton(
                                            icon: Icon(_obscureText
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () {
                                              setState(() =>
                                                  _obscureText = !_obscureText);
                                            }),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    TextFormField(
                                      validator: (val) {
                                        if (val.isEmpty) {
                                          return 'Please confirm your password';
                                        } else if (val != password) {
                                          return 'Password does not match';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (val) {},
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        labelText: "Confirm Password",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Material(
                                      borderRadius: BorderRadius.circular(30.0),
                                      elevation: 5.0,
                                      child: MaterialButton(
                                        onPressed: () async {
                                          if (_formkey.currentState
                                              .validate()) {
                                            setState(() => loading = true);
                                            dynamic result = await _auth
                                                .registerWithEmailAndPassword(
                                                    email, password);
                                            if (result == null) {
                                              setState(() => loading = false);
                                              setState(() => error =
                                                  'Please provide a valid E-mail');
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
                                          "Sign Up",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
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
                );
              } else {
                return Home();
              }
            });
  }
}
