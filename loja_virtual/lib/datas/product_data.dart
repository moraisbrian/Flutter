import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String title;
  String description;
  double price;
  List images;
  List sizes;
  String category;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.data()['title'];
    description = snapshot.data()['description'];
    price = snapshot.data()['price'] + 0.0;
    images = snapshot.data()['images'];
    sizes = snapshot.data()['sizes'];
  }

  Map<String, dynamic> toResumedMap() => {'title': title, 'price': price};
}
