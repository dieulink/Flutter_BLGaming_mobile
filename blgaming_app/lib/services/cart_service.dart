import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:blgaming_app/models/request/add_cart_request.dart';
import 'package:blgaming_app/models/response/cart_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartService {
  static Future<CartResponse?> fetchCart(String userId) async {
    final url = Uri.parse('http://192.168.5.139:8080/api/cart?userId=$userId');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
      );

      print("Status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final data = json.decode(response.body);
        return CartResponse.fromJson(data);
      } else {
        print("Lỗi khi fetch cart: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("$e");
      return null;
    }
  }

  static Future<bool> updateCartQuantity({
    required int gameId,
    required String userId,
    required int quantity,
  }) async {
    final url = Uri.parse('http://192.168.5.139:8080/api/cart');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final body = {"gameId": gameId, "userId": userId, "quantity": quantity};

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Lỗi status: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Lỗi khi cập nhật số lượng giỏ hàng: $e");
      return false;
    }
  }

  static Future<int> deleteFromCart(int gameId, String userId) async {
    final url = Uri.parse('http://192.168.5.139:8080/api/cart');
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    try {
      final response = await http.delete(
        url,
        headers: {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'gameId': gameId, 'userId': userId}),
      );
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Trả về 200 hoặc 204 (thành công)
        return response.statusCode;
      } else {
        print('Lỗi xóa sản phẩm: ${response.statusCode}');
        return response.statusCode; // Trả về mã lỗi
      }
    } catch (e) {
      print('Lỗi khi xóa sản phẩm khỏi giỏ hàng: $e');
      return 0;
    }
  }
}
