import 'package:farm_app1/Models/stockclass.dart';
import 'package:farm_app1/screen/home/stock_list.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class Stock extends StatefulWidget {
  final String uid;
  Stock({this.uid});
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  String stockName;
  int stockPrice;
  int stockQuantity;
  final _formkey = GlobalKey<FormState>();

  Future addDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
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
                Center(
                  child: Card(
                    elevation: 8.0,
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Enter the product name';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() => this.stockName = val);
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.shopping_basket),
                                labelText: "Stock Name",
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
                                  return 'Enter the product price';
                                } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                                  return 'Enter a valid price';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(
                                    () => this.stockPrice = int.parse(val));
                              },
                              decoration: InputDecoration(
                                labelText: "Stock Price",
                                prefixIcon: Icon(Icons.attach_money),
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
                                  return 'Enter the product quantity';
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
                                    Navigator.of(context).pop();
                                    await DatabaseService(
                                            uid: widget.uid,
                                            stockUid: stockName)
                                        .addProduct(
                                            this.stockName,
                                            this.stockPrice,
                                            this.stockQuantity);
                                  }
                                },
                                minWidth: 150.0,
                                height: 30.0,
                                child: Text(
                                  "Add Product",
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
    return StreamProvider<List<Stocks>>.value(
      value: DatabaseService(uid: widget.uid).stocks,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          title: Text('Stock'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                addDialog(context);
              },
            ),
          ],
        ),
        body: StockList(
          uid: widget.uid,
        ),
      ),
    );
  }
}
