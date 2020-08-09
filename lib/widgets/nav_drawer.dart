import 'package:flutter/material.dart';
import 'package:farm_app1/service/auth.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 150,
              color: Colors.lightGreen,
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.update,
                  color: Colors.lightGreen,
                ),
                title: Text(
                  'Update Inventory List',
                  style: TextStyle(color: Colors.lightGreen),
                ),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.show_chart,
                  color: Colors.lightGreen,
                ),
                title: Text(
                  'Sales Chart',
                  style: TextStyle(color: Colors.lightGreen),
                ),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.lightGreen,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.lightGreen),
                ),
                onTap: () async {
                  await _auth.signOut();
                },
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
