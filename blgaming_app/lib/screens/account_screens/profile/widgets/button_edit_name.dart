import 'package:flutter/material.dart';
import 'package:blgaming_app/models/request/edit_user_request.dart';
import 'package:blgaming_app/services/user_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ButtonEditName extends StatelessWidget {
  final String text;
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const ButtonEditName({
    super.key,
    required this.text,
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
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token');
        final userId = prefs.getString('userId');

        if (token == null || userId == null) {
          _showSnack(context, "Không lấy được thông tin người dùng.");
          return;
        }

        final name = nameController.text.trim();
        final phone = phoneController.text.trim();

        if (name.isEmpty && phone.isEmpty) {
          _showSnack(
            context,
            "Vui lòng nhập tên hoặc số điện thoại để cập nhật!",
          );
          return;
        }

        // Validate cơ bản
        final nameRegex = RegExp(r'^[a-zA-ZÀ-ỹ\s]+$');
        final phoneRegex = RegExp(r'^(0|\+84)[0-9]{9}$');

        if (name.isNotEmpty && !nameRegex.hasMatch(name)) {
          _showSnack(context, "Tên không hợp lệ!");
          return;
        }

        if (phone.isNotEmpty && !phoneRegex.hasMatch(phone)) {
          _showSnack(context, "Số điện thoại không hợp lệ!");
          return;
        }

        final request = EditUserRequest(
          userId: userId,
          fullName: name,
          phone: phone,
        );

        final response = await UserService.editUser(request);
        print(response?.message);
        if (response != null && response.message == "success") {
          await prefs.setString('name', name);
          await prefs.setString('phone', phone);

          _showSnack(
            context,
            "Cập nhật thành công!",
            bgColor: Colors.green,
            icon: Icons.check_circle_outline,
          );

          await Future.delayed(const Duration(milliseconds: 800));
          Navigator.pushReplacementNamed(context, "home");
        } else {
          _showSnack(context, "Cập nhật thất bại! Vui lòng thử lại.");
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
