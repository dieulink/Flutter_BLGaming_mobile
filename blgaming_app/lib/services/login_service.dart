import 'dart:convert';
import 'package:blgaming_app/models/request/gg_login_request.dart';
import 'package:blgaming_app/models/response/register_response.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:blgaming_app/models/request/user_login_request.dart';
import 'package:blgaming_app/models/request/user_register_request.dart';
import 'package:blgaming_app/models/request/user_reset_password_request.dart';
import 'package:blgaming_app/models/response/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService {
  static Future<LoginResponse?> login(UserLoginRequest request) async {
    final url = Uri.parse('http://192.168.5.138:8080/api/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );
      print(response.body);
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);

          if (json['accessToken'] != null &&
              json['accessToken'].toString().isNotEmpty) {
            final prefs = await SharedPreferences.getInstance();
            Map<String, dynamic> decodedToken = JwtDecoder.decode(
              json['accessToken'],
            );
            print(decodedToken);
            String userId = decodedToken['userId'];
            String name = decodedToken['fullName'];
            String email = decodedToken['sub'];
            String role = decodedToken['role'];

            await prefs.setString('token', json['accessToken']);
            await prefs.setString('userId', userId);
            await prefs.setString('name', name);
            await prefs.setString('email', email);
            await prefs.setString('role', role);
            String phone = decodedToken['phone'];
            await prefs.setString('phone', phone);

            print("SharedPreferences");
            print("ID: ${prefs.getString('userId')}");
            print("Tên: ${prefs.getString('name')}");
            print("Email: ${prefs.getString('email')}");
            print("Vai trò: ${prefs.getString('role')}");
            print("token: ${prefs.getString('token')}");
          }
          return LoginResponse.fromJson(json);
        }
      } else {
        print('Lỗi');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API: $e');
      return null;
    }
  }

  static Future<RegisterResponse?> register(UserRegisterRequest request) async {
    final url = Uri.parse('http://192.168.5.138:8080/api/auth/register');
    try {
      final resp = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      if (resp.statusCode == 200 && resp.body.isNotEmpty) {
        final json = jsonDecode(resp.body) as Map<String, dynamic>;
        return RegisterResponse.fromJson(json);
      }
      return null;
    } catch (e) {
      print("Register error: $e");
      return null;
    }
  }

  static Future<String?> confirmEmail(String email) async {
    final url = Uri.parse(
      'http://192.168.5.138:8080/api/forgot-password/verifyEmail?email=${email}',
    );

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return jsonData['message'] ?? 'Xác nhận email thành công.';
      } else {
        print("Lỗi khi xác nhận email: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi confirmEmail: $e");
      return null;
    }
  }

  static Future<String?> resetPassword(UserResetPasswordRequest request) async {
    final url = Uri.parse(
      'http://192.168.5.138:8080/api/forgot-password/verifyOtp',
    );
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(request.toJson()),
      );

      print("Status: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final jsonData = jsonDecode(response.body);
        return jsonData['message'] ?? 'Mật khẩu đã được đặt lại thành công.';
      } else {
        print("Lỗi đặt lại mật khẩu: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Lỗi resetPassword: $e");
      return null;
    }
  }

  static Future<LoginResponse?> loginWithGoogle(GgLoginRequest req) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/auth/google');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(req.toJson()),
      );

      print("Google Login Response: ${response.body}");

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['accessToken'] != null &&
            json['accessToken'].toString().isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();

          Map<String, dynamic> decodedToken = JwtDecoder.decode(
            json['accessToken'],
          );

          print("Decoded Token Google: $decodedToken");

          String userId = decodedToken['userId'] ?? '';
          String name = decodedToken['fullName'] ?? '';
          String email = decodedToken['sub'] ?? '';
          String role = decodedToken['role'] ?? '';
          String phone = decodedToken['phone'] ?? '';

          await prefs.setString('token', json['accessToken']);
          await prefs.setString('userId', userId);
          await prefs.setString('name', name);
          await prefs.setString('email', email);
          await prefs.setString('role', role);
          await prefs.setString('phone', phone);

          print("--- SharedPreferences (Google Login) ---");
          print("ID: ${prefs.getString('userId')}");
          print("Tên: ${prefs.getString('name')}");
          print("Email: ${prefs.getString('email')}");
          print("Vai trò: ${prefs.getString('role')}");
          print("Token: ${prefs.getString('token')}");
        }

        return LoginResponse.fromJson(json);
      } else {
        print('Google Login Failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Lỗi khi gọi API Google Login: $e');
      return null;
    }
  }
}
