import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:myshop_admin/Model/product_model.dart';
import 'package:myshop_admin/provider/product_provider.dart';
import 'package:myshop_admin/screens/edit_product_screen.dart';
import 'package:myshop_admin/screens/product_detail_screen.dart';
import 'package:myshop_admin/utils/utils.dart';
import 'package:provider/provider.dart';

class ProductListView extends StatelessWidget {
  final List<ProductModel> products;

  const ProductListView({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final productprovider = Provider.of<ProductProvider>(context);
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return InkWell(
          onTap: () {
            Utils.navigateTo(
              context,
              ProductDetailScreen(
                imageUrl: product.productImageUrls,
                title: product.title,
                originalPrice: product.originalPrice,
                price: product.discountprice,
                rating: product.rating,
                description: product.description,
                videoUrl: product.productvideourl,
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Divider(height: 0),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: ListTile(
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.black),
                        onPressed: () {
                          Utils.navigateTo(
                              context, EditProductScreen(product: product));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.black),
                        onPressed: () async {
                          productprovider.deleteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: const BoxDecoration(color: Colors.blue),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: product.productImageUrls.first,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  title: Text(
                    product.title,
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 1),
                            child: Text(
                              '\$${product.discountprice}',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Text(
                              '(\$${product.originalPrice})',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontStyle: FontStyle.italic,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          RatingStars(
                            value: product.rating,
                            starSize: 16,
                            valueLabelColor: Colors.amber,
                            starColor: Colors.amber,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
