import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blgaming_app/models/response/product.dart';
import 'package:blgaming_app/models/response/product_category.dart';

class CategoryService {
  static Future<List<ProductCategory>> fetchCategories() async {
    try {
      final url = Uri.parse('http://192.168.5.138:8080/api/public/categories');
      final response = await http.get(url);

      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((item) => ProductCategory.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load categories (code ${response.statusCode})',
        );
      }
    } catch (e, s) {
      print("Lỗi fetchCategories: $e\n$s");
      return [];
    }
  }

  static Future<List<Product>> categoryItem({
    required int id,
    required int page,
    required int size,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.138:8080/api/public/game-by-category?pageNo=$page&pageSize=$size&categoryId=$id',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['gameList'] ?? [];

        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load products (status ${response.statusCode})',
        );
      }
    } catch (e, s) {
      print("Lỗi categoryItem: $e\n$s");
      return [];
    }
  }

  //search in category
}
