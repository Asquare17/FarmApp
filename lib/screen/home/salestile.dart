import 'package:farm_app1/Models/salesclass.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class SalesTile extends StatefulWidget {
  final SalesClass sales;
  final String uid;
  SalesTile({this.sales, this.uid});
  @override
  _SalesTileState createState() => _SalesTileState();
}

class _SalesTileState extends State<SalesTile> {
  Future showDetailsDialog(BuildContext context) async {
    String date = DateFormat('dd-MM-yyyy').format(widget.sales.timeSold);
    String time = DateFormat.jm().format(widget.sales.timeSold);
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                'SALES DETAILS',
                style: TextStyle(
                  color: Colors.lightGreen,
                ),
              ),
            ),
            content: ListView(
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: Colors.lightGreen,
                      ),
                    ),
                    Text(
                      'Stock Sold:',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      widget.sales.nameSold,
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Total Price:',
                        style: TextStyle(
                          fontSize: 10,
                        )),
                    Text(
                      "\$${widget.sales.totalpriceSold}",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Quantity(s) Sold:',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "${widget.sales.quantitySold}",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Cost per unit:',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "\$${widget.sales.priceSold}",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Time Sold:',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "$time",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Date Sold:',
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "$date",
                      style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Material(
                        elevation: 5.0,
                        color: Colors.lightGreen[700],
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          minWidth: 150.0,
                          height: 30.0,
                          child: Center(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    String date = DateFormat('dd-MM-yyyy').format(widget.sales.timeSold);
    String time = DateFormat.jm().format(widget.sales.timeSold);
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.lightGreen,
          ),
          title: Text(widget.sales.nameSold),
          subtitle: Text(
              'Total Price: \$${widget.sales.totalpriceSold}\nDate: $date, Time: $time'),
          trailing: IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showDetailsDialog(context);
            },
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
