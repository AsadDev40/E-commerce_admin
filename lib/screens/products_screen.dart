import 'package:flutter/material.dart';
import 'package:myshop_admin/Model/product_model.dart';
import 'package:myshop_admin/provider/product_provider.dart';
import 'package:myshop_admin/screens/add_product_screen.dart';
import 'package:myshop_admin/utils/utils.dart';
import 'package:myshop_admin/widgets/product_widget.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshProducts() async {
    await Provider.of<ProductProvider>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // scaffoldKey.currentState!
              // .showBottomSheet((context) => const ShopSearch());
            },
          )
        ],
        title: const Text('Products'),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: Provider.of<ProductProvider>(context, listen: false)
            .fetchProducts(),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshProducts,
              child: ProductListView(products: snapshot.data!),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigateTo(context, const AddProductScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
    );
  }
}
