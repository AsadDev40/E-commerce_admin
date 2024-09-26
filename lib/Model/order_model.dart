import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String orderId;
  final String productId;
  final String productTitle;
  final int quantity;
  final double price;
  final String customerId;
  final String status;
  final String customername;
  final String customeraddress;
  final String customerphone;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final List<String> images;

  OrderModel({
    required this.orderId,
    required this.productId,
    required this.productTitle,
    required this.quantity,
    required this.price,
    required this.customerId,
    required this.status,
    required this.customername,
    required this.customeraddress,
    required this.customerphone,
    required this.orderDate,
    required this.deliveryDate,
    required this.images,
  });

  // Convert a Firestore document to an OrderModel
  // Convert a Firestore document to an OrderModel
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    try {
      return OrderModel(
        orderId: json['orderId'] ?? '',
        productId: json['productId'],
        productTitle: json['productTitle'],
        quantity: json['quantity'],
        price: json['price'].toDouble(),
        customerId: json['customerId'],
        status: json['status'],
        customername: json['customername'],
        customeraddress: json['customeraddress'],
        customerphone: json['customerphone'],
        images: (json['images'] as List<dynamic>)
            .map((image) => image as String)
            .toList(),
        orderDate: (json['orderDate'] as Timestamp).toDate(),
        deliveryDate: (json['deliveryDate'] as Timestamp).toDate(),
      );
    } catch (e) {
      print(
          'Error parsing order data: $e'); // Debugging output for errors in parsing JSON
      throw Exception('Error parsing order data: $e');
    }
  }

  // Convert an OrderModel to a JSON object for Firestore
  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'productId': productId,
      'productTitle': productTitle,
      'quantity': quantity,
      'price': price,
      'customerId': customerId,
      'status': status,
      'customername': customername,
      'customeraddress': customeraddress,
      'customerphone': customerphone,
      'orderDate': orderDate,
      'deliveryDate': deliveryDate,
      'images': images,
    };
  }

  // Helper method to create a copy of the model with updated fields
  OrderModel copyWith({
    String? orderId,
    String? productId,
    String? productTitle,
    int? quantity,
    double? price,
    String? customerId,
    String? status,
    String? customername,
    String? customeraddress,
    String? customerphone,
    DateTime? orderDate,
    DateTime? deliveryDate,
    List<String>? images,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      customerId: customerId ?? this.customerId,
      status: status ?? this.status,
      customername: customername ?? this.customername,
      customeraddress: customeraddress ?? this.customeraddress,
      customerphone: customerphone ?? this.customerphone,
      orderDate: orderDate ?? this.orderDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      images: images ?? this.images,
    );
  }
}
