import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_app1/Models/salesclass.dart';
import 'package:farm_app1/Models/stockclass.dart';

//Database class
class DatabaseService {
  final String uid; //unique user uid from firebase
  final String stockUid; //product uid or name

  DatabaseService({this.uid, this.stockUid}); //initiaizing the named parameter

  //a collection of stocks
  final CollectionReference stockCollection =
      Firestore.instance.collection('stocks');

  //add data function that allows user to add new stocks taking the name, price and quantity as argument
  Future addProduct(
    String name,
    int price,
    int quantity,
  ) async {
    return await stockCollection
        .document(uid)
        .collection('Stocks')
        .document(stockUid)
        .setData({
      'Name': name,
      'Price': price,
      'Quantity': quantity,
    }, merge: true);
  }

  Future updateStock(
    int quantity,
  ) async {
    return await stockCollection
        .document(uid)
        .collection('Stocks')
        .document(stockUid)
        .setData({
      'Quantity': quantity,
    }, merge: true);
  }

  Future updatePrice(
    int price,
  ) async {
    return await stockCollection
        .document(uid)
        .collection('Stocks')
        .document(stockUid)
        .setData({
      'Price': price,
    }, merge: true);
  }

//stocklist from snapshot
  List<Stocks> _stocksListFromSnapshot(QuerySnapshot snapshot1) {
    return snapshot1.documents.map((doc) {
      return Stocks(
          name: doc.data['Name'] ?? 'Empty',
          price: doc.data['Price'] ?? 0,
          quantity: doc.data['Quantity'] ?? 0);
    }).toList();
  }

  Stream<List<Stocks>> get stocks {
    return Firestore.instance
        .collection('stocks')
        .document(uid)
        .collection('Stocks')
        .snapshots()
        .map(_stocksListFromSnapshot);
  }

  //a collection of sales
  final CollectionReference salesCollection =
      Firestore.instance.collection('Sales');

  //add data function that allows user to add new sales taking the name, price and quantity as argument
  Future addSales({
    String nameSold,
    int priceSold,
    int quantitySold,
    DateTime timeSold,
  }) async {
    return await salesCollection
        .document(uid)
        .collection('Sales')
        .document()
        .setData({
      'NameSold': nameSold,
      'PriceSold': priceSold,
      'QuantitySold': quantitySold,
      'TimeSold': timeSold,
    }, merge: true);
  }

  //stocklist from snapshot
  List<SalesClass> _salesListFromSnapshot(QuerySnapshot snapshot2) {
    return snapshot2.documents.map((doc) {
      return SalesClass(
        nameSold: doc.data['NameSold'] ?? 'Empty',
        priceSold: doc.data['PriceSold'] ?? 0,
        quantitySold: doc.data['QuantitySold'] ?? 0,
        timeSold: DateTime.parse((doc.data['TimeSold']).toDate().toString()) ??
            DateTime(0),
        totalpriceSold: (doc.data['PriceSold'] * doc.data['QuantitySold']) ?? 0,
      );
    }).toList();
  }

  Stream<List<SalesClass>> get sales {
    return Firestore.instance
        .collection('Sales')
        .document(uid)
        .collection('Sales')
        .snapshots()
        .map(_salesListFromSnapshot);
  }
}
