import 'package:cafe3awan/models/menu_model.dart';
// import 'package:http/http.dart' as http;

// A simple API service that contains endpoints per model (menu, cart...)
class MenuService {
  // Base URL - for demonstration only; we will not actually call it when "simulating".
  static const String baseUrl = 'http://localhost:5000/api';

  // Endpoint path helpers
  static String menuEndpoint() => '\$baseUrl/menu';
  static String cartEndpoint() => '\$baseUrl/cart';

  // Example: get menu list (simulate by returning sample data)
  static Future<List<MenuItemModel>> fetchMenu() async {
    // In a real app you would call http.get(Uri.parse(menuEndpoint()))
    await Future.delayed(const Duration(milliseconds: 700)); // simulate network

    final sampleJson = [
      {
        'id': '1',
        'name': 'Coffe Latte',
        'imageUrl':
            'https://images.unsplash.com/photo-1541167760496-1628856ab772',
        'price': 28.0,
        'category': 'Coffee',
      },
      {
        'id': '2',
        'name': 'Iced Tea Lemon',
        'imageUrl':
            'https://images.unsplash.com/photo-1511920170033-f8396924c348',
        'price': 18.5,
        'category': 'Drink',
      },
      {
        'id': '3',
        'name': 'Grilled Chicken',
        'imageUrl':
            'https://images.unsplash.com/photo-1604908177545-3d3b1e4b2c1c',
        'price': 45.0,
        'category': 'Main Course',
      },
    ];

    return sampleJson.map((j) => MenuItemModel.fromJson(j)).toList();
  }

  // Simulate posting cart
  static Future<bool> postCart(Map<String, dynamic> payload) async {
    // In the real app use http.post(Uri.parse(cartEndpoint()), body: jsonEncode(payload))
    await Future.delayed(const Duration(milliseconds: 800)); // simulate network
    // Return true to indicate success in simulation
    return true;
  }
}
