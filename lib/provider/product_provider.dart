import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myshop_admin/Model/product_model.dart';

class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Upload product
  Future<String> addProduct(ProductModel product) async {
    try {
      DocumentReference docRef =
          await _firestore.collection('products').add(product.toJson());
      await _firestore
          .collection('products')
          .doc(docRef.id)
          .update({'id': docRef.id});

      notifyListeners();
      return docRef.id;
    } catch (e) {
      return '';
    }
  }

  // Fetch products
  Future<List<ProductModel>> fetchProducts() async {
    QuerySnapshot querySnapshot = await _firestore.collection('products').get();

    return querySnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // Update product
  Future<void> updateProduct(
      String productId, ProductModel updatedProduct) async {
    try {
      await _firestore
          .collection('products')
          .doc(productId)
          .update(updatedProduct.toJson());
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  // Delete product
  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      notifyListeners(); // Notify listeners of the change
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(String category) async {
    final QuerySnapshot querySnapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    return querySnapshot.docs
        .map((doc) => ProductModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
