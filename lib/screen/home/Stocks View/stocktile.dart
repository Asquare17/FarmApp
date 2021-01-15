import 'package:farm_app1/Models/stockclass.dart';
import 'package:farm_app1/screen/home/Stocks View/stockdetails.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';

class StockTile extends StatefulWidget {
  final Stocks stocks;
  final String uid;
  StockTile({this.stocks, this.uid});

  @override
  _StockTileState createState() => _StockTileState();
}

class _StockTileState extends State<StockTile> {
  String stockName;
  int stockPrice;
  final _formkey = GlobalKey<FormState>();

  Future editPriceDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'Edit Price',
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
                                widget.stocks.name,
                                style: TextStyle(color: Colors.lightGreen),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              child: Text(
                                'Old Price: \$${widget.stocks.price}',
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
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[\\-|\\ ]'))
                              ],
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Enter new stock\'s price';
                                } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                                  return 'Enter a valid quantity';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(
                                    () => this.stockPrice = int.parse(val));
                              },
                              decoration: InputDecoration(
                                labelText: "New Price",
                                prefixIcon: Icon(Icons.attach_money),
                              ),
                            ),
                            SizedBox(height: 20),
                            Material(
                              elevation: 5.0,
                              color: Colors.lightGreen[700],
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    this.stockPrice = stockPrice;
                                    Navigator.of(context).pop();
                                    await DatabaseService(
                                            uid: widget.uid,
                                            stockUid: widget.stocks.name)
                                        .updatePrice(this.stockPrice);
                                  }
                                },
                                minWidth: 150.0,
                                height: 30.0,
                                child: Text(
                                  "CHANGE",
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
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StockDetails(
                          uid: widget.uid,
                          stockUid: widget.stocks.name,
                        )));
          },
          leading: CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.lightGreen,
          ),
          title: Text(widget.stocks.name),
          subtitle: Text(
              'Price: # ${widget.stocks.price}\nQuantity Available: ${widget.stocks.quantity}'),
          trailing: IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              editPriceDialog(context);
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
