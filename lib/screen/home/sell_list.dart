import 'package:farm_app1/Models/stockclass.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/service/database.dart';

class SellList extends StatefulWidget {
  final String uid;
  List<Stocks> unfilteredstocks;
  SellList({this.uid, this.unfilteredstocks});
  @override
  _SellListState createState() => _SellListState();
}

class _SellListState extends State<SellList> {
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
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
              hintText: 'Find people on Greamit',
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
                  : SellTile(
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
  int quantity;
  Future number;
  DateTime time;
  Stream sales = DatabaseService().sales;
  final _formkey = GlobalKey<FormState>();

  Future sellStockDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
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
                                height: 3,
                              ),
                              Text(
                                'Quantity(s) Available:',
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                "${widget.stocks.quantity}",
                                style: TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 15,
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
                                    return 'Enter quantity to sell';
                                  } else if (!RegExp(r"^[0-9]*$")
                                      .hasMatch(val)) {
                                    return 'Enter a valid quantity';
                                  } else if (int.parse(val) >
                                      widget.stocks.quantity) {
                                    return 'Not enough stock!';
                                  } else {
                                    return null;
                                  }
                                },
                                onChanged: (val) {
                                  setState(() => quantity = int.parse(val));
                                },
                                decoration: InputDecoration(
                                  labelText: "Stock Quantity",
                                  prefixIcon: Icon(Icons.shopping_cart),
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: Material(
                                  elevation: 5.0,
                                  color: Colors.lightGreen[700],
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        this.stockQuantity =
                                            widget.stocks.quantity - quantity;
                                        time = DateTime.now();
                                        Navigator.of(context).pop();
                                        await DatabaseService(
                                                uid: widget.uid,
                                                stockUid: widget.stocks.name)
                                            .updateStock(this.stockQuantity);
                                        await DatabaseService(
                                          uid: widget.uid,
                                        ).addSales(
                                          nameSold: widget.stocks.name,
                                          priceSold: widget.stocks.price,
                                          quantitySold: quantity,
                                          timeSold: time,
                                          type: false,
                                        );
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
          subtitle: Text(
              'Price: \$${widget.stocks.price},\nAvailable: ${widget.stocks.quantity}'),
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
