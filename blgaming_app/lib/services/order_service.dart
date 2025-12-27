import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:blgaming_app/models/request/order_request.dart';
import 'package:blgaming_app/models/response/order_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderService {
  Future<bool> createOrder(OrderRequest order) async {
    final url = Uri.parse('http://192.168.5.139:8080/api/order/add_order');

    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print(token);
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(order.toJson()),
      );

      if (response.statusCode == 200) {
        print('Tạo đơn hàng thành công: ${response.body}');
        return true;
      } else {
        print('Tạo đơn hàng thất bại: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return false;
    }
  }

  Future<List<OrderResponse>> getOrdersByUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? id = prefs.getString("userId");
    int userId = int.parse(id!);
    final url = Uri.parse(
      'http://192.168.5.139:8080/api/order/list_order/user?userId=$userId',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => OrderResponse.fromJson(json)).toList();
      } else {
        throw Exception(
          "Lỗi khi lấy danh sách đơn hàng: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }

  Future<OrderResponse> getOrdersByOrderId(int id) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    final url = Uri.parse(
      'http://192.168.5.139:8080/api/order/order_detail?orderId=$id',
    );
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return OrderResponse.fromJson(json);
      } else {
        throw Exception(
          "Lỗi khi lấy danh sách đơn hàng: ${response.statusCode}",
        );
      }
    } catch (e) {
      throw Exception("Lỗi kết nối tới server: $e");
    }
  }
}
