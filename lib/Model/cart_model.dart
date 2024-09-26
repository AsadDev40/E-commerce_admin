class CartItem {
  String? cartId;
  final String productId;
  final String title;
  final int price;
  int quantity;
  final String firstImagePath;

  CartItem({
    required this.cartId,
    required this.productId,
    required this.title,
    required this.price,
    required this.quantity,
    required this.firstImagePath,
  });

  // from json
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      cartId: json['cartId'],
      productId: json['productId'],
      title: json['title'],
      price: json['price'],
      quantity: json['quantity'],
      firstImagePath: json['firstImagePath'],
    );
  }

  // to json
  Map<String, dynamic> toJson() => {
        'cartId': cartId,
        'productId': productId,
        'title': title,
        'price': price,
        'quantity': quantity,
        'firstImagePath': firstImagePath,
      };
}
