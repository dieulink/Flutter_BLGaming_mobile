import 'package:flutter/material.dart';
import 'package:blgaming_app/models/request/user_reset_password_request.dart';
import 'package:blgaming_app/services/login_service.dart';
import 'package:blgaming_app/ui_value.dart';

class ButtonInputResetPassword extends StatelessWidget {
  final String text;
  final String email;
  final TextEditingController otpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const ButtonInputResetPassword({
    super.key,
    required this.text,
    required this.otpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.email,
  });

  void _showSnack(
    BuildContext context,
    String message, {
    IconData icon = Icons.error_outline,
    Color color = textColor1,
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
        backgroundColor: color,
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
        final otp = otpController.text.trim();
        final password = passwordController.text.trim();
        final passwordConfirm = confirmPasswordController.text.trim();

        if (otp.isEmpty || password.isEmpty || passwordConfirm.isEmpty) {
          _showSnack(context, "Vui lòng nhập đầy đủ thông tin");
          return;
        }

        final RegExp passwordRegex = RegExp(r'^[a-zA-Z0-9]{6,8}$');
        if (!passwordRegex.hasMatch(password)) {
          _showSnack(
            context,
            "Mật khẩu từ 6-8 kí tự, chỉ chứa chữ cái và số !",
          );
          return;
        }

        if (passwordConfirm != password) {
          _showSnack(context, "Vui lòng xác thực mật khẩu !");
          return;
        }

        final request = UserResetPasswordRequest(
          email: email,
          newPassword: password,
          repeatPassword: passwordConfirm,
          otp: int.tryParse(otp) ?? 0,
        );

        final message = await LoginService.resetPassword(request);

        if (message != null) {
          _showSnack(
            context,
            message,
            icon: Icons.check_circle_outline,
            color: Colors.green,
          );

          await Future.delayed(const Duration(seconds: 1));
          Navigator.pushNamed(context, "loginPage");
        } else {
          _showSnack(
            context,
            "Mã OTP không hợp lệ hoặc đã hết hạn.",
            icon: Icons.error_outline,
            color: textColor1,
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
