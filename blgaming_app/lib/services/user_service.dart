import 'dart:convert';
import 'package:blgaming_app/models/request/edit_user_request.dart';
import 'package:blgaming_app/models/response/edit_user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<EditUserResponse?> editUser(EditUserRequest request) async {
    final url = Uri.parse('http://192.168.5.139:8080/user/updateInformation');

    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final headers = {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

      final resp = await http.post(
        url,
        headers: headers,
        body: jsonEncode(request.toJson()),
      );

      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body);
        return EditUserResponse.fromJson(json);
      } else {
        print("Lỗi cập nhật user: ${resp.statusCode} - ${resp.body}");
        return null;
      }
    } catch (e) {
      print("Lỗi cập nhật user: $e");
      return null;
    }
  }
}
