import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChatService {
  final String baseUrl = "http://192.168.5.138:8080/api/ai/chat";

  Future<String?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<String> sendMessage(String message) async {
    final userId = await _getUserId();
    final token = await _getToken();

    if (userId == null) {
      throw Exception("Không tìm thấy userId trong SharedPreferences");
    }

    final url = Uri.parse("$baseUrl?userId=$userId");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        if (token != null) "Authorization": "Bearer $token",
      },
      body: jsonEncode({"message": message}),
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception("Error ${response.statusCode}: ${response.body}");
    }
  }
}
