import 'package:flutter/material.dart';
import 'package:farm_app1/Models/stockclass.dart';

class StockTile extends StatelessWidget {
  final Stocks stocks;
  StockTile({this.stocks});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightGreen,
          ),
          title: Text(stocks.name),
          subtitle: Text(
              'Price: # ${stocks.price},  Quantity Available: # ${stocks.quantity}'),
          trailing: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
