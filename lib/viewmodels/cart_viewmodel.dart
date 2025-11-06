import 'package:cafe3awan/core/services/menu_service.dart';
import 'package:cafe3awan/models/cart_model.dart';
import 'package:cafe3awan/models/menu_model.dart';
import 'package:flutter/material.dart';

class CartViewModel extends ChangeNotifier {
  final Map<String, CartItem> _items = {};

  List<CartItem> get items => _items.values.toList();

  int get totalItems => _items.length;
  int get totalQty => _items.values.fold(0, (s, e) => s + e.qty);
  double get totalPrice => _items.values.fold(0.0, (s, e) => s + e.total);

  void add(MenuItemModel menu) {
    if (_items.containsKey(menu.id)) {
      _items[menu.id]!.qty++;
    } else {
      _items[menu.id] = CartItem(item: menu, qty: 1);
    }
    notifyListeners();
  }

  void removeSingle(String id) {
    if (!_items.containsKey(id)) return;
    final cartItem = _items[id]!;
    if (cartItem.qty > 1)
      cartItem.qty--;
    else
      _items.remove(id);
    notifyListeners();
  }

  void removeAll(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  Future<bool> placeOrder({
    required String paymentMethod,
    required double paidAmount,
  }) async {
    // Build payload
    final payload = {
      'items': _items.values
          .map(
            (c) => {
              'id': c.item.id,
              'name': c.item.name,
              'price': c.item.price,
              'qty': c.qty,
            },
          )
          .toList(),
      'totalPrice': totalPrice,
      'totalQty': totalQty,
      'paymentMethod': paymentMethod,
      'paidAmount': paidAmount,
    };

    // Simulate API call to POST http://localhost:5000/api/cart
    final success = await MenuService.postCart(payload);
    if (success) clear(); // on success clear cart
    return success;
  }
}
