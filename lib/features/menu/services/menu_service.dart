import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/food_item.dart';

class MenuService {
  final FirebaseFirestore firebaseFirestore;

  MenuService(this.firebaseFirestore);

  final _menuCollection = FirebaseFirestore.instance.collection('menu');

  Future<List<FoodItem>> getMenu() async {
    try {
      final data = await _menuCollection.get();
      final docs = data.docs;
      final menu = await Future.wait(
        docs.map((doc) async => FoodItem.fromMap(doc.data(), doc.id)),
      );
      return menu;
    } catch (e) {
      print('Error fetching menu: $e');
      return [];
    }
  }
}
