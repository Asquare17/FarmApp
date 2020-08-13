import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_app1/screen/home/sales.dart';
import 'package:farm_app1/screen/home/sell.dart';
import 'package:farm_app1/screen/home/stock.dart';
import 'package:farm_app1/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm_app1/screen/home/add_stock.dart';
import 'package:intl/intl.dart';
import 'package:farm_app1/service/database.dart';
import 'package:farm_app1/Models/salesclass.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid;
  double totalsale;
  double tp;
  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.currentUser().then((res) {
      uid = res.uid;
    });
    double counter = 0;
    int totalPrice;

    Firestore.instance
        .collection('Sales')
        .document(uid)
        .collection('Sales')
        .snapshots()
        .listen((data) {
      data.documents.forEach((doc) {
        totalPrice = doc['PriceSold'] * doc['QuantitySold'];
        counter += totalPrice;
      });

      setState(() {
        totalsale = counter;
        return totalsale;
      });
    });
    // final sales = Provider.of<List<SalesClass>>(context);

    // sales.forEach((element) {
    //   a += element.priceSold;
    // });
    return StreamProvider<List<SalesClass>>.value(
        value: DatabaseService(uid: uid).sales,
        child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.lightGreen,
            title: Text('Farm App'),
          ),
          body: ListView(
            children: <Widget>[
              Container(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    Container(
                      width: 300,
                      child: RaisedButton(
                          padding: EdgeInsets.all(15.0),
                          onPressed: () {},
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                              side: BorderSide(color: Colors.lightGreen)),
                          child: Text(
                            "Total Sales is \$$totalsale",
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.lightGreen,
                            ),
                          )),
                    ),
                    Container(
                      width: 300,
                      child: StreamBuilder(
                        stream: Firestore.instance
                            .collection('Sales')
                            .document(uid)
                            .collection('Sales')
                            .orderBy('TimeSold', descending: true)
                            .limit(4)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          return !snapshot.hasData
                              ? Text('No Sales yet')
                              : ListView.builder(
                                  itemCount: snapshot.data.documents.length,
                                  itemBuilder: (context, index) {
                                    DocumentSnapshot sales =
                                        snapshot.data.documents[index];
                                    int pricesold = sales['PriceSold'] *
                                        sales['QuantitySold'];
                                    DateTime dateTime = DateTime.parse(
                                        (sales['TimeSold'])
                                            .toDate()
                                            .toString());
                                    String date = DateFormat('dd-MM-yyyy')
                                        .format(dateTime);
                                    String time =
                                        DateFormat.jm().format(dateTime);
                                    return Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Card(
                                        margin:
                                            EdgeInsets.fromLTRB(20.0, 6, 20, 0),
                                        child: ListTile(
                                          title: Text(sales['NameSold']),
                                          subtitle: Text(
                                              'Price: \$$pricesold\nDate: $date, Time: $time'),
                                          isThreeLine: true,
                                        ),
                                      ),
                                    );
                                  },
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    child: Container(
                      height: 100,
                      width: 150,
                      color: Colors.lightGreen,
                      child: FlatButton.icon(
                        onPressed: () {
                          FirebaseAuth.instance.currentUser().then((res) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Stock(
                                          uid: res.uid,
                                        )));
                          });
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                        label: Text(
                          'Stock',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                        height: 100,
                        width: 150,
                        color: Colors.lightGreen,
                        child: FlatButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser().then((res) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sales(
                                              uid: res.uid,
                                            )));
                              });
                            },
                            icon: Icon(
                              Icons.account_balance_wallet,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Sales',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    child: Container(
                        height: 100,
                        width: 150,
                        color: Colors.lightGreen,
                        child: FlatButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser().then((res) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sell(
                                              uid: res.uid,
                                            )));
                              });
                            },
                            icon: Icon(
                              Icons.shopping_basket,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Sell',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                  Card(
                    child: Container(
                        height: 100,
                        width: 150,
                        color: Colors.lightGreen,
                        child: FlatButton.icon(
                            onPressed: () {
                              FirebaseAuth.instance.currentUser().then((res) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddStock(
                                              uid: res.uid,
                                            )));
                              });
                            },
                            icon: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Add Stock',
                              style: TextStyle(color: Colors.white),
                            ))),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
