import 'package:farm_app1/Models/stockclass.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/service/database.dart';

class SellList extends StatefulWidget {
  final String uid;
  SellList({this.uid});
  @override
  _SellListState createState() => _SellListState();
}

class _SellListState extends State<SellList> {
  @override
  Widget build(BuildContext context) {
    final stocks = Provider.of<List<Stocks>>(context);
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return SellTile(
          stocks: stocks[index],
          uid: widget.uid,
        );
      },
    );
  }
}

class SellTile extends StatefulWidget {
  final Stocks stocks;
  final String uid;
  SellTile({this.stocks, this.uid});

  @override
  _SellTileState createState() => _SellTileState();
}

class _SellTileState extends State<SellTile> {
  String stockName;
  int stockPrice;
  int stockQuantity;
  final _formkey = GlobalKey<FormState>();

  Future sellStockDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Sell Stocks',
                style: TextStyle(
                  color: Colors.lightGreen,
                ),
              ),
            ),
            content: ListView(
              children: <Widget>[
                Center(
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Stock:  ${widget.stocks.name}',
                                style: TextStyle(color: Colors.lightGreen),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: Text(
                                'Price:  ${widget.stocks.price}',
                                style: TextStyle(color: Colors.lightGreen),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                BlacklistingTextInputFormatter(
                                    new RegExp('[\\-|\\ ]'))
                              ],
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Enter quantity to sell';
                                } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                                  return 'Enter a valid quantity';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(
                                    () => this.stockQuantity = int.parse(val));
                              },
                              decoration: InputDecoration(
                                labelText: "Stock Quantity",
                                prefixIcon: Icon(Icons.shopping_cart),
                              ),
                            ),
                            SizedBox(height: 20),
                            Material(
                              elevation: 5.0,
                              color: Colors.lightGreen[700],
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    this.stockQuantity =
                                        widget.stocks.quantity - stockQuantity;
                                    Navigator.of(context).pop();
                                    await DatabaseService(
                                            uid: widget.uid,
                                            stockUid: widget.stocks.name)
                                        .addStock(this.stockQuantity);
                                  }
                                },
                                minWidth: 150.0,
                                height: 30.0,
                                child: Text(
                                  "SELL",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

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
          title: Text(widget.stocks.name),
          subtitle: Text(
              'Price: # ${widget.stocks.price},Available: # ${widget.stocks.quantity}'),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              sellStockDialog(context);
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
