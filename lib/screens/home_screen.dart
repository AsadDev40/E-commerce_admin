import 'package:flutter/material.dart';
import 'package:myshop_admin/screens/category_screen.dart';
import 'package:myshop_admin/screens/orders_list_screen.dart';
import 'package:myshop_admin/screens/products_screen.dart';
import 'package:myshop_admin/screens/users_screen.dart';
import 'package:myshop_admin/utils/utils.dart';
import 'package:myshop_admin/widgets/box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome Admin',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Utils.navigateTo(context, OrderScreen());
                  },
                  child: const Custombox(
                    title: 'Orders',
                    bordercolor: Colors.purple,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.navigateTo(context, const ProductsScreen());
                  },
                  child: const Custombox(
                    title: 'Products',
                    bordercolor: Colors.purple,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Utils.navigateTo(context, const UsersScreen());
                  },
                  child: const Custombox(
                    title: 'Users',
                    bordercolor: Colors.purple,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Utils.navigateTo(context, const CategoryScreen());
                  },
                  child: const Custombox(
                    title: 'Categories',
                    bordercolor: Colors.purple,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
