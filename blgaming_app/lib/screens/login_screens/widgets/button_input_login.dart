import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:blgaming_app/models/request/user_login_request.dart';
import 'package:blgaming_app/models/response/login_response.dart';
import 'package:blgaming_app/services/login_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonInput extends StatelessWidget {
  final String text;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const ButtonInput({
    super.key,
    required this.text,
    required this.emailController,
    required this.passwordController,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();

        if (email.isEmpty || password.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Vui lòng nhập đầy đủ thông tin",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]{6,8}$');

        if (!emailRegex.hasMatch(email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Email không hợp lệ !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        if (!passwordRegex.hasMatch(password)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Mật khẩu từ 6-8 kí tự, chỉ chứa chữ cái và số !",
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
          return;
        }
        final request = UserLoginRequest(email: email, password: password);

        final loginService = LoginService();
        final response = await LoginService.login(request);
        print(
          "Token value: ${response?.token}, isNull: ${response?.token == null}",
        );
        final prefs = await SharedPreferences.getInstance();
        if (prefs.getString("token") != null) {
          final prefs = await SharedPreferences.getInstance();
          String role = prefs.getString('role') ?? '';
          if (role == 'ROLE_ADMIN') {
            Navigator.pushNamed(context, "adminPage");
          } else if (role == 'ROLE_USER') {
            Navigator.pushNamed(context, "home");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Vai trò không hợp lệ",
                  style: TextStyle(fontFamily: "LD"),
                ),
                backgroundColor: textColor1,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: const EdgeInsets.all(30),
                duration: const Duration(seconds: 1),
                elevation: 8,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(Icons.error_outline, color: white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      response!.message,
                      style: TextStyle(fontFamily: "LD"),
                    ),
                  ),
                ],
              ),
              backgroundColor: textColor1,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(30),
              duration: const Duration(seconds: 1),
              elevation: 8,
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: SizedBox(
        width: getWidth(context),
        height: 60,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: white,
              fontFamily: "LD",
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
