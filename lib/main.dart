import 'package:farm_app1/Models/user.dart';
import 'package:farm_app1/screen/authenticate/SignIn.dart';
import 'package:farm_app1/screen/authenticate/register.dart';
import 'package:farm_app1/screen/authenticate/welcome.dart';
import 'package:farm_app1/screen/home/AddStock View/add_stock.dart';
import 'package:farm_app1/screen/home/Sales View/sales.dart';
import 'package:farm_app1/screen/home/Sell View/sell.dart';
import 'package:farm_app1/screen/home/Stocks View/stock.dart';
import 'package:farm_app1/service/auth.dart';
import 'package:farm_app1/screen/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        routes: {
          '/welcome': (context) => Welcome(),
          '/signIn': (context) => SignIn(),
          '/register': (context) => Register(),
          '/stock': (context) => Stock(),
          '/sales': (context) => Sales(),
          '/sell': (context) => Sell(),
          '/add_stock': (context) => AddStock(),
        },
        home: Wrapper(),
      ),
    );
  }
}
