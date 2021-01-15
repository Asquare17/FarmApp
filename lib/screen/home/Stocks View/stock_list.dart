import 'package:farm_app1/Models/stockclass.dart';
import 'package:farm_app1/screen/home/Stocks%20View/stocktile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StockList extends StatefulWidget {
  final String uid;
  List<Stocks> unfilteredstocks;
  StockList({this.uid, this.unfilteredstocks});
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
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
              hintText: 'Search Stock',
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
                  : StockTile(
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
