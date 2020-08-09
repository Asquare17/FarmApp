import 'package:farm_app1/screen/home/stockList2.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/Models/stockclass.dart';

class AddStock extends StatefulWidget {
  final String uid;
  AddStock({this.uid});
  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stocks>>.value(
        value: DatabaseService(uid: widget.uid).stocks,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Text('Add Stock'),
          ),
          body: StockList2(
            uid: widget.uid,
          ),
        ));
  }
}
