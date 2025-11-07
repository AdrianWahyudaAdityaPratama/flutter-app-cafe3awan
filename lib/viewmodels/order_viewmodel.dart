import 'package:cafe3awan/core/services/order_service.dart';
import 'package:cafe3awan/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderViewModel extends ChangeNotifier {
  List<OrderModel> _orders = [];
  bool _loading = false;

  List<OrderModel> get orders => _orders;
  bool get loading => _loading;

  Future<void> loadOrders() async {
    _loading = true;
    notifyListeners();

    _orders = await OrderService.fetchOrders();

    _loading = false;
    notifyListeners();
  }
}
