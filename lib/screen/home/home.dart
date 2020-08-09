import 'package:farm_app1/screen/home/sell.dart';
import 'package:farm_app1/screen/home/stock.dart';
import 'package:farm_app1/widgets/nav_drawer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:farm_app1/screen/home/add_stock.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        // leading: IconButton(
        //     icon: Icon(
        //       Icons.menu,
        //       color: Colors.white,
        //     ),
        //     onPressed: () {}),
        backgroundColor: Colors.lightGreen,
        title: Text('FarmApp'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Card(
                  child: Container(
                    color: Colors.black,
                    width: 300,
                  ),
                ),
                Card(
                  child: Container(
                    color: Colors.yellow,
                    width: 399,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Card(
                child: Container(
                  height: 150,
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
                    height: 150,
                    width: 150,
                    color: Colors.lightGreen,
                    child: FlatButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/sales');
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
                    height: 150,
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
                    height: 150,
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
    );
  }
}
