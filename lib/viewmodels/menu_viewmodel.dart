import 'package:cafe3awan/core/services/menu_service.dart';
import 'package:cafe3awan/models/menu_model.dart';
import 'package:flutter/material.dart';

class MenuViewModel extends ChangeNotifier {
  List<MenuItemModel> _items = [];
  bool _loading = false;

  List<MenuItemModel> get items => _items;
  bool get loading => _loading;

  Future<void> loadMenu({String? search, String? category}) async {
    _loading = true;
    notifyListeners();
    try {
      _items = await MenuService.fetchMenu(search: search, category: category);
    } catch (e) {
      _items = [];
    }
    _loading = false;
    notifyListeners();
  }
}
