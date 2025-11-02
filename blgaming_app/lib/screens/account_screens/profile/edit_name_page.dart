import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/account_screens/profile/profile_page.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/button_edit_name.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/text_edit.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNamePage extends StatefulWidget {
  const EditNamePage({super.key});

  @override
  State<EditNamePage> createState() => _EditNamePageState();
}

class _EditNamePageState extends State<EditNamePage> {
  String name = "";
  String id = "";
  String phone = "";

  @override
  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name') ?? 'Không có';
      id = prefs.getString('userId') ?? 'Không có';
      phone = prefs.getString('phone') ?? 'Không có';
    });
  }

  void initState() {
    super.initState();
    _loadUser();
  }

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    return Scaffold(
      appBar: AppBarProfile(name: "Tên người dùng"),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 100),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Tên",
                  style: TextStyle(
                    color: white,
                    fontFamily: "LD",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                child: TextEdit(hintText: name, controller: nameController),
              ),
              SizedBox(height: 30),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "* Số điện thoại",
                  style: TextStyle(
                    color: white,
                    fontFamily: "LD",
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextEdit(hintText: phone, controller: phoneController),
              SizedBox(height: 50),
              ButtonEditName(
                text: "Chỉnh sửa",
                nameController: nameController,
                phoneController: phoneController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
