import 'package:farm_app1/screen/home/sales_list.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/Models/salesclass.dart';

class Sales extends StatefulWidget {
  final String uid;
  Sales({this.uid});
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SalesClass>>.value(
      value: DatabaseService(uid: widget.uid).sales,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Sales'),
        ),
        body: SalesList(
          uid: widget.uid,
        ),
      ),
    );
  }
}
