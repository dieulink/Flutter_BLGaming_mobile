import 'package:flutter/material.dart';
import 'package:blgaming_app/models/request/user_register_request.dart';
import 'package:blgaming_app/services/login_service.dart';
import 'package:blgaming_app/ui_value.dart';

class ButtonInputRegister extends StatelessWidget {
  final String text;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const ButtonInputRegister({
    super.key,
    required this.text,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.phoneController,
  });

  void _showSnack(
    BuildContext context,
    String message, {
    Color bgColor = const Color(0xFF222222),
    IconData icon = Icons.error_outline,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(message, style: const TextStyle(fontFamily: "LD")),
            ),
          ],
        ),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(30),
        duration: const Duration(seconds: 1),
        elevation: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        final email = emailController.text.trim();
        final password = passwordController.text.trim();
        final phone = phoneController.text.trim();
        final name = nameController.text.trim();

        if (email.isEmpty ||
            password.isEmpty ||
            phone.isEmpty ||
            name.isEmpty) {
          _showSnack(context, "Vui lòng nhập đầy đủ thông tin");
          return;
        }

        final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]{6,8}$');
        final RegExp phoneRegex = RegExp(r'^(0|\+84)[0-9]{9}$');
        final RegExp nameRegex = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');

        if (!emailRegex.hasMatch(email)) {
          _showSnack(context, "Email không hợp lệ !");
          return;
        }
        if (!passwordRegex.hasMatch(password)) {
          _showSnack(
            context,
            "Mật khẩu từ 6-8 kí tự, chỉ chứa chữ cái và số !",
          );
          return;
        }
        if (!phoneRegex.hasMatch(phone)) {
          _showSnack(context, "Số điện thoại không hợp lệ !");
          return;
        }
        if (name.length > 50) {
          _showSnack(context, "Tên đăng kí quá dài !");
          return;
        }
        if (!nameRegex.hasMatch(name)) {
          _showSnack(context, "Tên đăng kí không chứa số và kí tự đặc biệt !");
          return;
        }

        final request = UserRegisterRequest(
          fullName: name,
          email: email,
          password: password,
          phone: phone,
        );

        final res = await LoginService.register(request);

        final bool isSuccess =
            res != null && (res.status).toString().toLowerCase() == 'ok';

        if (isSuccess) {
          _showSnack(
            context,
            "Đăng ký thành công! Vui lòng đăng nhập.",
            bgColor: Colors.green,
            icon: Icons.check_circle_outline,
          );

          await Future.delayed(const Duration(milliseconds: 800));
          Navigator.pushReplacementNamed(context, "loginPage");
        } else {
          _showSnack(context, "Đăng ký thất bại! Vui lòng thử lại.");
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
            style: const TextStyle(
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
