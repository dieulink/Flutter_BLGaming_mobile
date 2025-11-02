import 'package:flutter/material.dart';
import 'package:blgaming_app/services/login_service.dart';
import 'package:blgaming_app/ui_value.dart';

class ButtonInputConfirmPassword extends StatelessWidget {
  final String text;
  final TextEditingController emailController;

  const ButtonInputConfirmPassword({
    super.key,
    required this.text,
    required this.emailController,
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
        print(email);
        if (email.isEmpty) {
          _showSnack(context, "Vui lòng nhập đầy đủ thông tin");
          return;
        }
        final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
        if (!emailRegex.hasMatch(email)) {
          _showSnack(context, "Email không hợp lệ !");
          return;
        }

        final response = await LoginService.confirmEmail(email);

        if (response != null && response.isNotEmpty) {
          _showSnack(
            context,
            response,
            bgColor: Colors.green,
            icon: Icons.check_circle_outline,
          );

          await Future.delayed(const Duration(milliseconds: 800));
          Navigator.pushNamed(context, "resetPasswordPage", arguments: email);
        } else {
          _showSnack(context, "Email chưa đăng ký hoặc lỗi server!");
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
