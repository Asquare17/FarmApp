import 'package:cloud_firestore/cloud_firestore.dart';
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
}
