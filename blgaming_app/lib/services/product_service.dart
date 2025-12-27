import 'dart:convert';
import 'package:blgaming_app/models/response/big_sale_item.dart';
import 'package:http/http.dart' as http;
import 'package:blgaming_app/models/response/item.dart';
import 'package:blgaming_app/models/response/product.dart';

class ProductService {
  static Future<List<Product>> fetchProducts({
    int page = 0,
    int size = 10,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.139:8080/api/public/game-list-new?pageNo=$page&pageSize=$size',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final List<dynamic> gameList = jsonData['gameList'] ?? [];

        return gameList.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load products (code ${response.statusCode})',
        );
      }
    } catch (e, s) {
      print("Lỗi fetchProducts: $e\n$s");
      return [];
    }
  }

  static Future<List<Product>> bestsale({int page = 0, int size = 10}) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.139:8080/api/public/game-best-sale?pageNo=$page&pageSize=$size',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        final List<dynamic> gameList = jsonData['gameList'] ?? [];

        return gameList.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load products (code ${response.statusCode})',
        );
      }
    } catch (e, s) {
      print("Lỗi fetchProducts: $e\n$s");
      return [];
    }
  }

  static Future<Item?> fetchProductItem(int id) async {
    try {
      final url = Uri.parse('http://192.168.5.139:8080/api/public/detail/$id');

      final response = await http.get(url);
      print("Status: ${response.statusCode}");
      print(response.body);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return Item.fromJson(jsonData);
      } else {
        print("Failed to load product: ${response.statusCode}");
        return null;
      }
    } catch (e, s) {
      print("Lỗi fetchProductItem: $e\n$s");
      return null;
    }
  }

  static Future<List<Product>> search({
    required String keyword,
    required int page,
    required int size,
  }) async {
    try {
      final url = Uri.parse(
        'http://192.168.5.139:8080/api/public/search-game?pageNo=$page&pageSize=$size&searchInput=$keyword',
      );

      final response = await http.get(url);
      print("Status: ${response.statusCode}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<dynamic> data = jsonData['gameList'] ?? [];

        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        throw Exception(
          'Failed to load products (status: ${response.statusCode})',
        );
      }
    } catch (e, s) {
      print("Lỗi search(): $e\n$s");
      return [];
    }
  }

  static Future<List<BigSaleItem>> fetchBigSaleToday() async {
    try {
      final url = Uri.parse(
        "http://192.168.5.139:8080/api/public/bigsale/today",
      );
      final res = await http.get(url);
      print(jsonDecode(res.body));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final List<dynamic> items = data["items"] ?? [];
        return items.map((e) => BigSaleItem.fromJson(e)).toList();
      } else {
        throw Exception("Failed BigSale: ${res.statusCode}");
      }
    } catch (e) {
      print("ERR fetchBigSale: $e");
      return [];
    }
  }
}
