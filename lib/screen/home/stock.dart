import 'package:farm_app1/Models/stockclass.dart';
import 'package:farm_app1/screen/home/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';

class Stock extends StatefulWidget {
  final String uid;
  Stock({this.uid});
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stocks>>.value(
      value: DatabaseService(uid: widget.uid).stocks,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Stock'),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                onPressed: () {})
          ],
        ),
        body: StockList(
          uid: widget.uid,
        ),
      ),
    );
  }
}
