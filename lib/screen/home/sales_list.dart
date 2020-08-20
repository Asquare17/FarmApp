import 'package:farm_app1/Models/salesclass.dart';
import 'package:farm_app1/screen/home/salestile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesList extends StatefulWidget {
  final String uid;
  SalesList({this.uid});
  @override
  _SalesListState createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  @override
  Widget build(BuildContext context) {
    final sales = Provider.of<List<SalesClass>>(context);
    return ListView.builder(
      itemCount: sales.length,
      itemBuilder: (context, index) {
        return sales.isEmpty
            ? Center(
                child: Text(
                  'No sales yet, Sell stocks',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen),
                ),
              )
            : SalesTile(
                sales: sales[index],
                uid: widget.uid,
              );
      },
    );
  }
}
