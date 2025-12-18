import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_register.dart';
import 'package:blgaming_app/screens/login_screens/widgets/text_input.dart';
import 'package:blgaming_app/ui_value.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    return Scaffold(
      backgroundColor: backgroudColor,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/imgs/background7.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(color: const Color.fromARGB(74, 0, 0, 0)),
          Container(
            padding: EdgeInsets.all(20),
            height: getHeight(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      "assets/imgs/logo_blue.png",
                      height: 150,
                    ),
                  ),

                  Text(
                    "Chào mừng đến với Linsta !",
                    style: TextStyle(
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: white,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(218, 0, 0, 0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Tạo tài khoản mới",
                          style: TextStyle(
                            fontFamily: "LD",
                            fontSize: 15,
                            color: textColor2,
                          ),
                        ),
                        SizedBox(height: 30),
                        TextInput(
                          controller: nameController,
                          isObscureText: false,
                          hintText: "Họ và tên",
                          iconPath: 'assets/icons/system_icon/24px/User.png',
                        ),
                        SizedBox(height: 20),
                        TextInput(
                          controller: phoneController,
                          isObscureText: false,
                          hintText: "Số điện thoại",
                          iconPath: 'assets/icons/system_icon/24px/Phone.png',
                        ),
                        SizedBox(height: 20),
                        TextInput(
                          controller: emailController,
                          isObscureText: false,
                          hintText: "Địa chỉ Email",
                          iconPath: 'assets/icons/system_icon/24px/Message.png',
                        ),
                        SizedBox(height: 20),
                        TextInput(
                          controller: passwordController,
                          isObscureText: true,
                          hintText: "Mật khẩu",
                          iconPath:
                              'assets/icons/system_icon/24px/Password.png',
                        ),
                        // SizedBox(height: 20),
                        // Container(
                        //   alignment: Alignment.bottomRight,
                        //   child: Image.asset(
                        //     "assets/imgs/pacman4.gif",
                        //     height: 25,
                        //   ),
                        // ),
                        ButtonInputRegister(
                          text: "Đăng kí",
                          emailController: emailController,
                          passwordController: passwordController,
                          nameController: nameController,
                          phoneController: phoneController,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn đã có tài khoản ?",
                              style: TextStyle(
                                color: textColor2,
                                fontFamily: "LD",
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "loginPage");
                              },
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  color: mainColor,
                                  fontFamily: "LD",
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
