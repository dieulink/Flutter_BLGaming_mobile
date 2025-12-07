import 'package:blgaming_app/models/request/gg_login_request.dart';
import 'package:blgaming_app/models/request/user_login_request.dart';
import 'package:blgaming_app/services/login_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/login_screens/widgets/app_bar_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/button_input_login.dart';
import 'package:blgaming_app/screens/login_screens/widgets/text_input.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebaseAuth;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  static const List<String> scopes = <String>[
    'email',
    'https://www.googleapis.com/auth/userinfo.email',
    'openid',
  ];

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '428940770122-s0rn6otg8ca3gpdjsht8gokssfvee3as.apps.googleusercontent.com',
    scopes: scopes,
  );

  signInWithGoogle() async {
    _googleSignIn.signOut();
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = firebaseAuth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final request = GgLoginRequest(idToken: credential.idToken!);
      final response = await LoginService.loginWithGoogle(request);
      if (response == null) {
        return null;
      }
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
    } catch (err) {
      // AppToast.showCustomError(
      //     'Hệ thống đang gặp sự cố, vui lòng thử lại sau.');
      return err.toString();
    }
  }

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
                        InkWell(
                            onTap: signInWithGoogle,
                            child:
                                Image.asset("assets/imgs/gg.png", height: 30)),
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
