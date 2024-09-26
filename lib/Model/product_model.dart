class ProductModel {
  // Constructor
  ProductModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.productImageUrls,
    required this.productvideourl,
    required this.discountprice,
    required this.originalPrice,
    required this.rating,
    required this.color,
    this.sale,
  });

  final String id;
  final String title;
  final String category;
  final String description;
  final List<String> productImageUrls;
  final String productvideourl;
  final double rating;
  final String originalPrice;
  final String discountprice;
  final String color;
  final String? sale;

  // from json
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        category: json['category'],
        description: json['description'],
        productvideourl: json['productvideourl'],
        originalPrice: json['originalprice'],
        discountprice: json['discountprice'],
        rating: json['rating'],
        color: json['color'],
        sale: json['sale'],
        productImageUrls: List<String>.from(json['productImageUrls']));
  }

  // to json
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'productvideourl': productvideourl,
        'category': category,
        'description': description,
        'productImageUrls': productImageUrls,
        'discountprice': discountprice,
        'originalprice': originalPrice,
        'rating': rating,
        'color': color,
        'sale': sale,
      };
}
