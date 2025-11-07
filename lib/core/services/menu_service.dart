import 'dart:convert';
import 'package:cafe3awan/models/menu_model.dart';
import 'package:http/http.dart' as http;

class MenuService {
  static const String baseUrl = 'http://localhost:5000';

  static String menuEndpoint() => '$baseUrl/menus';

  // Fetch menu list from backend
  static Future<List<MenuItemModel>> fetchMenu({
    String? search,
    String? category,
  }) async {
    try {
      // Buat URL dengan query params jika ada
      final uri = Uri.parse(menuEndpoint()).replace(
        queryParameters: {
          if (search != null && search.isNotEmpty) 'search': search,
          if (category != null && category.isNotEmpty) 'category': category,
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['data'];
        return data.map((j) => MenuItemModel.fromJson(j)).toList();
      } else {
        throw Exception(
          'Failed to load menu. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching menu: $e');
    }
  }
}
