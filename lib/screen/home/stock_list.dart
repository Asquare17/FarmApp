import 'package:farm_app1/Models/stockclass.dart';
import 'package:farm_app1/screen/home/stocktile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockList extends StatefulWidget {
  final String detail;
  StockList({this.detail});
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  @override
  Widget build(BuildContext context) {
    final stocks = Provider.of<List<Stocks>>(context);
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return StockTile(
          stocks: stocks[index],
        );
      },
    );
  }
}
