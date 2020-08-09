import 'package:farm_app1/screen/home/sell_list.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/Models/stockclass.dart';

class Sell extends StatefulWidget {
  final String uid;
  Sell({this.uid});
  @override
  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stocks>>.value(
        value: DatabaseService(uid: widget.uid).stocks,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Text('Sell'),
          ),
          body: SellList(
            uid: widget.uid,
          ),
        ));
  }
}
