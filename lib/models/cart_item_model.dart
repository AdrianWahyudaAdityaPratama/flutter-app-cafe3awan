import 'package:cafe3awan/models/menu_model.dart';

class CartItemModel {
  final MenuItemModel item;
  int qty;

  CartItemModel({required this.item, this.qty = 1});

  double get total => item.price * qty;
}
