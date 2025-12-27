import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PaypalService {
  static const String _baseUrl = 'http://192.168.5.139:8080/api';

  /// Tạo thanh toán PayPal và trả về approvalUrl (href)
  static Future<String> createPayment({
    required Map<String, dynamic> body,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('User not logged in');
    }

    final uri = Uri.parse('$_baseUrl/payment/create');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Create PayPal payment failed: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body);

    final approvalUrl = json['approvalUrl']?['href'];

    if (approvalUrl == null) {
      throw Exception('approvalUrl not found in response');
    }
    print(approvalUrl as String);

    return approvalUrl as String;
  }

  static Future<bool> handlePaymentSuccess({
    required String paymentId,
    required String payerId,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token == null) return false;

      final uri = Uri.parse(
        '$_baseUrl/payment/success'
        '?paymentId=$paymentId&PayerID=$payerId',
      );

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
