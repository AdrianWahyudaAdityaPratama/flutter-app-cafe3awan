import 'dart:convert';
import 'package:cafe3awan/models/order_model.dart';
import 'package:http/http.dart' as http;

class OrderService {
  static const String baseUrl = 'http://localhost:5000';

  static String ordersEndpoint() => '$baseUrl/orders';

  // Post order
  static Future<bool> postOrder(Map<String, dynamic> payload) async {
    try {
      final response = await http.post(
        Uri.parse(ordersEndpoint()),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Error posting order: $e');
      return false;
    }
  }

  // Get all orders
  static Future<List<OrderModel>> fetchOrders() async {
    try {
      final response = await http.get(Uri.parse(ordersEndpoint()));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['data'] as List;
        return data.map((e) => OrderModel.fromJson(e)).toList();
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error fetching orders: $e');
      return [];
    }
  }
}
