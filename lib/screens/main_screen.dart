import 'package:flutter/material.dart';
import 'package:myshop_admin/screens/add_product_screen.dart';
import 'package:myshop_admin/screens/home_screen.dart';
import 'package:myshop_admin/widgets/custom_bottom_navigation_bar.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _currentIndex = 0;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> _buildScreen() {
    return [
      const HomeScreen(),
      const AddProductScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: _buildScreen()[_currentIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
