import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/login_screens/widgets/app_bar_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/text_input.dart';
import 'package:blgaming_app/ui_value.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset("assets/imgs/background5.png"),
          Container(color: const Color.fromARGB(113, 0, 0, 14)),
          Container(
            height: getHeight(context),
            padding: EdgeInsets.all(20),
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
                    "Chào mừng đến với BLGaming !",
                    style: TextStyle(
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Image.asset("assets/imgs/pacman4.gif", height: 25),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor),
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromARGB(201, 0, 0, 14),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Đăng nhập để tiếp tục",
                          style: TextStyle(
                            fontFamily: "LD",
                            fontSize: 15,
                            color: textColor2,
                          ),
                        ),
                        SizedBox(height: 30),
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
                        SizedBox(height: 20),
                        ButtonInput(
                          text: "Đăng nhập",
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
                        SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "confirmEmailPage");
                          },
                          child: Text(
                            "Quên mật khẩu ?",
                            style: TextStyle(
                              color: white,
                              fontFamily: "LD",
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(height: 1, color: borderColor),
                        SizedBox(height: 10),
                        Text(
                          "Hoặc đăng nhập bằng ",
                          style: TextStyle(
                            color: textColor2,
                            fontFamily: "LD",
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 10),
                        Image.asset("assets/imgs/gg.png", height: 30),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa có tài khoản ?",
                              style: TextStyle(
                                color: textColor2,
                                fontFamily: "LD",
                                fontSize: 16,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, "registerPage");
                              },
                              child: Text(
                                "Đăng kí",
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
