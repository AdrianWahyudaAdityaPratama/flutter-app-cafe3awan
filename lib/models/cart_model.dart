import 'package:cafe3awan/models/menu_model.dart';

class CartItem {
  final MenuItemModel item;
  int qty;

  CartItem({required this.item, this.qty = 1});

  double get total => item.price * qty;
}
