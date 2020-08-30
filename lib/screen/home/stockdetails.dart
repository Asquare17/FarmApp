import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/Models/salesclass.dart';
import 'package:farm_app1/screen/home/salestile.dart';

class StockDetails extends StatefulWidget {
  final String uid;
  final String stockUid;
  StockDetails({this.uid, this.stockUid});
  @override
  _StockDetailsState createState() => _StockDetailsState();
}

class _StockDetailsState extends State<StockDetails> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<SalesClass>>.value(
        value: DatabaseService(uid: widget.uid, stockUid: widget.stockUid)
            .stocksales,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.lightGreen,
              title: Text('Stock Details'),
            ),
            body: StockDetailsList(
              uid: widget.uid,
              stockUid: widget.stockUid,
            )));
  }
}

class StockDetailsList extends StatefulWidget {
  final String uid;
  final String stockUid;
  StockDetailsList({this.uid, this.stockUid});
  @override
  _StockDetailsListState createState() => _StockDetailsListState();
}

class _StockDetailsListState extends State<StockDetailsList> {
  @override
  Widget build(BuildContext context) {
    final stocksales = Provider.of<List<SalesClass>>(context);
    return ListView.builder(
      itemCount: stocksales.length,
      itemBuilder: (context, index) {
        return stocksales.isEmpty
            ? Center(
                child: Text(
                  'No sales yet, Sell stocks',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen),
                ),
              )
            : SalesTile(
                sales: stocksales[index],
                uid: widget.uid,
              );
      },
    );
  }
}
