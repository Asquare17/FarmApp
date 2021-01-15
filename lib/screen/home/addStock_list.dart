import 'package:farm_app1/Models/stockclass.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/service/database.dart';

class AddStockList extends StatefulWidget {
  final String uid;
  List<Stocks> unfilteredstocks;
  AddStockList({this.uid, this.unfilteredstocks});
  @override
  _AddStockListState createState() => _AddStockListState();
}

class _AddStockListState extends State<AddStockList> {
  bool _isSearching = false;
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<Stocks> stocks = [];
    widget.unfilteredstocks = Provider.of<List<Stocks>>(context);
    widget.unfilteredstocks.forEach((element) {
      if (element.name
          .toLowerCase()
          .contains(searchEditingController.text.toLowerCase())) {
        stocks.add(element);
      }
    });

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                _isSearching = true;
              });
              if (!_isSearching) {
                setState(() {
                  value = '';
                });
              }
            },
            decoration: InputDecoration(
              hintText: 'Search Stocks',
              suffixIcon: _isSearching
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          searchEditingController.text = '';
                          _isSearching = !_isSearching;
                        });
                      },
                      icon: Icon(Icons.cancel),
                      color: Colors.grey,
                    )
                  : IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                      color: Colors.grey,
                    ),
            ),
            controller: searchEditingController,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          child: ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              return stocks.length < 1
                  ? Center(
                      child: Text(
                        'No stocks yet, Add Stock',
                        style:
                            TextStyle(fontSize: 20, color: Colors.lightGreen),
                      ),
                    )
                  : AddStockTile(
                      stocks: stocks[index],
                      uid: widget.uid,
                    );
            },
          ),
        ),
      ],
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
  DateTime time;
  int extraCost;
  int costPrice;
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
            content: SingleChildScrollView(
              child: Column(
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
                            Text('Selling price per unit:',
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
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[\\-|\\ ]'))
                              ],
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Enter the stock\'s quantity';
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
                            TextFormField(
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[\\-|\\ ]'))
                              ],
                              validator: (val) {
                                if (val.isEmpty) {
                                  return 'Enter the cost price';
                                } else if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                                  return 'Enter a valid price';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() => this.costPrice = int.parse(val));
                              },
                              decoration: InputDecoration(
                                labelText: "Cost Price",
                                hintText: 'Price bought per unit',
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
                                FilteringTextInputFormatter.deny(
                                    new RegExp('[\\-|\\ ]'))
                              ],
                              validator: (val) {
                                if (!RegExp(r"^[0-9]*$").hasMatch(val)) {
                                  return 'Enter a valid amount';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (val) {
                                setState(() => this.extraCost = int.parse(val));
                              },
                              decoration: InputDecoration(
                                labelText: "Extra Cost",
                                prefixIcon: Icon(Icons.add_box),
                              ),
                            ),
                            SizedBox(height: 20),
                            Material(
                              elevation: 5.0,
                              color: Colors.lightGreen[700],
                              child: MaterialButton(
                                onPressed: () async {
                                  if (_formkey.currentState.validate()) {
                                    time = DateTime.now();
                                    this.stockQuantity =
                                        stockQuantity + widget.stocks.quantity;
                                    Navigator.of(context).pop();
                                    await DatabaseService(
                                            uid: widget.uid,
                                            stockUid: widget.stocks.name)
                                        .updateStock(this.stockQuantity);
                                    await DatabaseService(
                                      uid: widget.uid,
                                    ).addSales(
                                      nameSold: widget.stocks.name,
                                      priceSold: costPrice,
                                      quantitySold: stockQuantity,
                                      timeSold: time,
                                      type: true,
                                      extraCost: extraCost,
                                    );
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
