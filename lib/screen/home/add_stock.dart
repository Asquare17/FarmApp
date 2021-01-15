import 'package:farm_app1/screen/home/addStock_list.dart';
import 'package:flutter/material.dart';
import 'package:farm_app1/service/database.dart';
import 'package:provider/provider.dart';
import 'package:farm_app1/Models/stockclass.dart';
import 'package:flutter/services.dart';

class AddStock extends StatefulWidget {
  final String uid;
  AddStock({this.uid});
  @override
  _AddStockState createState() => _AddStockState();
}

class _AddStockState extends State<AddStock> {
  String stockName;
  int stockPrice;
  int costPrice;
  int stockQuantity;
  DateTime time;
  int extraCost;
  final _formkey = GlobalKey<FormState>();

  Future addProductDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
              scrollable: true,
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
                                      return 'Enter the stock\'s name';
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
                                    FilteringTextInputFormatter.deny(
                                        new RegExp('[\\-|\\ ]'))
                                  ],
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Enter the cost price';
                                    } else if (!RegExp(r"^[0-9]*$")
                                        .hasMatch(val)) {
                                      return 'Enter a valid price';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(
                                        () => this.costPrice = int.parse(val));
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
                                    if (val.isEmpty) {
                                      return 'Enter the selling price';
                                    } else if (!RegExp(r"^[0-9]*$")
                                        .hasMatch(val)) {
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
                                    labelText: "Selling Price",
                                    hintText: 'Price to be sold per unit',
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
                                TextFormField(
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.deny(
                                        new RegExp('[\\-|\\ ]'))
                                  ],
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return 'Enter the cost or 0 if there isn\'t';
                                    } else if (!RegExp(r"^[0-9]*$")
                                        .hasMatch(val)) {
                                      return 'Enter a valid cost';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(
                                        () => this.extraCost = int.parse(val));
                                  },
                                  decoration: InputDecoration(
                                    labelText: "Extra Cost",
                                    hintText: 'Extra cost during purchase',
                                    prefixIcon: Icon(Icons.attach_money),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Material(
                                  elevation: 5.0,
                                  color: Colors.lightGreen[700],
                                  child: MaterialButton(
                                    onPressed: () async {
                                      if (_formkey.currentState.validate()) {
                                        time = DateTime.now();
                                        Navigator.of(context).pop();
                                        await DatabaseService(
                                                uid: widget.uid,
                                                stockUid: stockName)
                                            .addProduct(
                                                this.stockName,
                                                this.stockPrice,
                                                this.stockQuantity);
                                        await DatabaseService(
                                          uid: widget.uid,
                                        ).addSales(
                                          nameSold: this.stockName,
                                          priceSold: this.costPrice,
                                          quantitySold: this.stockQuantity,
                                          timeSold: time,
                                          type: true,
                                          extraCost: this.extraCost,
                                        );
                                      }
                                    },
                                    minWidth: 150.0,
                                    height: 30.0,
                                    child: Text(
                                      "Add Stock",
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
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Stocks>>.value(
        value: DatabaseService(uid: widget.uid).stocks,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Text('Add Stock'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    addProductDialog(context);
                  })
            ],
          ),
          body: AddStockList(
            uid: widget.uid,
          ),
        ));
  }
}

// List<Stocks> listStocksDuplicate = <Stocks>[];
//   List<Stocks> listStocks = <Stocks>[];
//   bool _isSearching = false;
//   TextEditingController searchEditingController = TextEditingController();
//   Future<List<Stocks>> getStocks() async {
//     QuerySnapshot snapshot1 =
//         await FirestoreCloudDb().getUsersCollection().getDocuments();
//     return snapshot1.documents
//         .map((doc) => Stocks.fromJson(doc.data))
//         .toList();
//   }

//   getModel() async {
//     listStocksDuplicate = await getStocks();
//   }

//   void filterSearchResults(String query) {
//     List<Stocks> dummySearchList = List<Stocks>();
//     dummySearchList.addAll(listStocksDuplicate);
//     if (query.isNotEmpty) {
//       List<Stocks> dummyListData = List<Stocks>();
//       dummySearchList.forEach((item) {
//         if (item.name.contains(query) ) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         listStocks.clear();
//         listStocks.addAll(dummyListData);
//       });
//       return;
//     } else {
//       setState(() {
//         listStocks.clear();
//         listStocks.addAll(listStocksDuplicate);
//       });
//     }
//   }
