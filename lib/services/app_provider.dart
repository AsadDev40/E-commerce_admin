import 'package:flutter/material.dart';
import 'package:myshop_admin/provider/auth_provider.dart';
import 'package:myshop_admin/provider/category_provider.dart';
import 'package:myshop_admin/provider/file_upload_provider.dart';
import 'package:myshop_admin/provider/image_picker_provider.dart';
import 'package:myshop_admin/provider/order_provider.dart';
import 'package:myshop_admin/provider/product_provider.dart';
import 'package:myshop_admin/provider/sale_provider.dart';
import 'package:myshop_admin/provider/video_picker_provider.dart';
import 'package:provider/provider.dart';

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ImagePickerProvider()),
          ChangeNotifierProvider(create: (context) => VideoPickerProvider()),
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => FileUploadProvider()),
          ChangeNotifierProvider(create: (context) => ProductProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(create: (context) => CategoryProvider()),
          ChangeNotifierProvider(create: (context) => SaleProvider()),
          ChangeNotifierProvider(create: (context) => OrderProvider()),
        ],
        child: child,
      );
}
