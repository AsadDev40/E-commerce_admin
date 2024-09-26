import 'package:flutter/material.dart';

class SaleProvider with ChangeNotifier {
  List<String> saleOptions = [
    'No Sale',
    'Summer Sale - 50% Off',
    'Clearance Sale - 30% Off',
    'Winter Sale - 40% Off',
  ];

  String? _selectedSale = 'No Sale';

  String? get selectedSale => _selectedSale;

  void updateSelectedSale(String sale) {
    _selectedSale = sale;
    notifyListeners();
  }
}
