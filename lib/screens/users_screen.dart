import 'package:flutter/material.dart';
import 'package:myshop_admin/Model/user_model.dart';
import 'package:myshop_admin/provider/auth_provider.dart';

import 'package:myshop_admin/widgets/user_listview.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  UsersScreenState createState() => UsersScreenState();
}

class UsersScreenState extends State<UsersScreen> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _refreshProducts() async {
    await Provider.of<AuthProvider>(context, listen: false).fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          )
        ],
        title: const Text('Users'),
      ),
      body: FutureBuilder<List<UserModel>>(
        future:
            Provider.of<AuthProvider>(context, listen: false).fetchAllUsers(),
        builder:
            (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products available'));
          } else {
            return RefreshIndicator(
              onRefresh: _refreshProducts,
              child: UserviewList(users: snapshot.data!),
            );
          }
        },
      ),
    );
  }
}
