import 'package:farm_app1/Models/stockclass.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/service/database.dart';

class AddStockList extends StatefulWidget {
  final String uid;
  AddStockList({this.uid});
  @override
  _AddStockListState createState() => _AddStockListState();
}

class _AddStockListState extends State<AddStockList> {
  @override
  Widget build(BuildContext context) {
    final stocks = Provider.of<List<Stocks>>(context);
    return ListView.builder(
      itemCount: stocks.length,
      itemBuilder: (context, index) {
        return stocks.isEmpty
            ? Center(
                child: Text(
                  'No stock yet, Add Stock',
                  style: TextStyle(fontSize: 20, color: Colors.lightGreen),
                ),
              )
            : AddStockTile(
                stocks: stocks[index],
                uid: widget.uid,
              );
      },
    );
  }
}

class AddStockTile extends StatefulWidget {
  final Stocks stocks;
  final String uid;
  AddStockTile({this.stocks, this.uid});

  @override
  _AddStockTileState createState() => _AddStockTileState();
}

class _AddStockTileState extends State<AddStockTile> {
  String stockName;
  int stockQuantity;
  final _formkey = GlobalKey<FormState>();

  Future addStockDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Add Stocks',
                style: TextStyle(
                  color: Colors.lightGreen,
                ),
              ),
            ),
            content: ListView(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Card(
                      elevation: 8.0,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Text(
                                'Stock Name:',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                widget.stocks.name,
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text('Cost per unit:',
                                  style: TextStyle(
                                    fontSize: 10,
                                  )),
                              Text(
                                "\$${widget.stocks.price}",
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
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
                                    return 'Enter the stock\'s quantity';
                                  } else if (!RegExp(r"^[0-9]*$")
                                      .hasMatch(val)) {
                                    return 'Enter a valid quantity';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() =>
                                      this.stockQuantity = int.parse(val));
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
                                      this.stockQuantity = stockQuantity +
                                          widget.stocks.quantity;
                                      Navigator.of(context).pop();
                                      await DatabaseService(
                                              uid: widget.uid,
                                              stockUid: widget.stocks.name)
                                          .updateStock(this.stockQuantity);
                                    }
                                  },
                                  minWidth: 150.0,
                                  height: 30.0,
                                  child: Text(
                                    "ADD",
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
                  ],
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
            radius: 15.0,
            backgroundColor: Colors.lightGreen,
          ),
          title: Text(widget.stocks.name),
          subtitle: Text('Quantity Available: ${widget.stocks.quantity}'),
          trailing: IconButton(
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              addStockDialog(context);
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
