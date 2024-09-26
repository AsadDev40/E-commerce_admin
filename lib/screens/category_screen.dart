import 'package:flutter/material.dart';
import 'package:myshop_admin/Model/category_model.dart';
import 'package:myshop_admin/provider/category_provider.dart';
import 'package:myshop_admin/screens/add_category_screen.dart';
import 'package:myshop_admin/utils/utils.dart';
import 'package:myshop_admin/widgets/category_listview.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshProducts() async {
    await Provider.of<CategoryProvider>(context, listen: false)
        .fetchCategories();
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
        title: const Text('Categories'),
      ),
      body: FutureBuilder<List<CategoryModel>>(
        future: Provider.of<CategoryProvider>(context, listen: false)
            .fetchCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Categories available'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshProducts,
              child: CategoryListview(cat: snapshot.data!),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Utils.navigateTo(context, const AddCategoryScreen());
        },
        child: const Icon(
          Icons.add,
          color: Colors.purple,
        ),
      ),
    );
  }
}
