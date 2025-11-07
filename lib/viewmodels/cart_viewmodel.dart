import 'package:cafe3awan/core/services/order_service.dart';
import 'package:cafe3awan/models/cart_item_model.dart';
import 'package:cafe3awan/models/menu_model.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final Map<int, CartItemModel> _items = {};

  List<CartItemModel> get items => _items.values.toList();

  int get totalItems => _items.length;
  int get totalQty => _items.values.fold(0, (s, e) => s + e.qty);
  double get totalPrice => _items.values.fold(0.0, (s, e) => s + e.total);

  void add(MenuItemModel menu) {
    if (_items.containsKey(menu.id)) {
      _items[menu.id]!.qty++;
    } else {
      _items[menu.id] = CartItemModel(item: menu, qty: 1);
    }
    notifyListeners();
  }

  void removeSingle(int id) {
    if (!_items.containsKey(id)) return;
    final cartItem = _items[id]!;
    if (cartItem.qty > 1)
      cartItem.qty--;
    else
      _items.remove(id);
    notifyListeners();
  }

  void removeAll(int id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  Future<bool> placeOrder({required String customerName}) async {
    if (_items.isEmpty) return false;

    // Build payload sesuai format baru
    final payload = {
      'customer_name': customerName,
      'items': _items.values
          .map((c) => {'menu_id': c.item.id, 'quantity': c.qty})
          .toList(),
    };

    // Simulate API call ke OrderService
    final success = await OrderService.postOrder(payload);

    if (success) clear(); // clear cart jika sukses
    return success;
  }
}
