import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/login_screens/widgets/app_bar_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_confirm_password.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/text_input.dart';
import 'package:blgaming_app/ui_value.dart';

class ConfirmEmailPage extends StatelessWidget {
  const ConfirmEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/imgs/background7.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(color: const Color.fromARGB(74, 0, 0, 0)),
          Center(
            child: SingleChildScrollView(
              child: Container(
                height: getHeight(context),
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(201, 0, 0, 14),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: mainColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 80),

                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(218, 0, 0, 0),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/imgs/logo_blue.png",
                              height: 150,
                            ),
                          ),
                          Text(
                            "Xác nhận Email của bạn",
                            style: TextStyle(
                              fontFamily: "LD",
                              fontSize: 15,
                              color: textColor2,
                            ),
                          ),
                          SizedBox(height: 50),
                          TextInput(
                            controller: emailController,
                            isObscureText: false,
                            hintText: "Địa chỉ Email",
                            iconPath:
                                'assets/icons/system_icon/24px/Message.png',
                          ),
                          SizedBox(height: 30),
                          ButtonInputConfirmPassword(
                            text: "Xác nhận Email",
                            emailController: emailController,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
