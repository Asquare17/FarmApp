import 'package:farm_app1/Models/salesclass.dart';
import 'package:farm_app1/screen/home/salestile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesList extends StatefulWidget {
  final String uid;
  List<SalesClass> unfilteredsales;
  SalesList({this.uid, this.unfilteredsales});
  @override
  _SalesListState createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  bool _isSearching = false;
  TextEditingController searchEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    List<SalesClass> sales = [];
    widget.unfilteredsales = Provider.of<List<SalesClass>>(context);
    widget.unfilteredsales.forEach((element) {
      if (element.nameSold
          .toLowerCase()
          .contains(searchEditingController.text.toLowerCase())) {
        sales.add(element);
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
            itemCount: sales.length,
            itemBuilder: (context, index) {
              return sales.isEmpty
                  ? Center(
                      child: Text(
                        'No sales yet, Sell Stocks',
                        style:
                            TextStyle(fontSize: 20, color: Colors.lightGreen),
                      ),
                    )
                  : SalesTile(
                      sales: sales[index],
                      uid: widget.uid,
                    );
            },
          ),
        ),
      ],
    );
  }
}
