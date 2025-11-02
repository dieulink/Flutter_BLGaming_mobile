import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/account_screens/list_order/detail_ordered.dart';
import 'package:blgaming_app/screens/account_screens/list_order/done_order_page.dart';
import 'package:blgaming_app/screens/account_screens/list_order/list_order_page.dart';
import 'package:blgaming_app/screens/account_screens/list_order/processing_page.dart';
import 'package:blgaming_app/screens/account_screens/list_order/shipping_page.dart';
import 'package:blgaming_app/screens/account_screens/profile/edit_name_page.dart';
import 'package:blgaming_app/screens/account_screens/profile/profile_page.dart';
import 'package:blgaming_app/screens/home_screens/cart_page.dart';
import 'package:blgaming_app/screens/home_screens/category_item_page.dart';
import 'package:blgaming_app/screens/home_screens/home.dart';
import 'package:blgaming_app/screens/home_screens/home_page.dart';
import 'package:blgaming_app/screens/home_screens/product_detail.dart';
import 'package:blgaming_app/screens/home_screens/search_item_page.dart';
import 'package:blgaming_app/screens/login_screens/confirm_email_page.dart';
import 'package:blgaming_app/screens/login_screens/login_page.dart';
import 'package:blgaming_app/screens/login_screens/on_boarding_page.dart';
import 'package:blgaming_app/screens/login_screens/register_page.dart';
import 'package:blgaming_app/screens/login_screens/reset_password_page.dart';
import 'package:blgaming_app/screens/order_screens/order_page.dart';
import 'package:blgaming_app/screens/rating/rating_page.dart';
import 'package:blgaming_app/screens/rating/write_rating_page.dart';
import 'package:blgaming_app/screens/rating/your_rating_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: backgroudColor),
      routes: {
        "/": (context) => OnBoardingPage(),
        "loginPage": (context) => LoginPage(),
        "registerPage": (context) => RegisterPage(),
        "confirmEmailPage": (context) => ConfirmEmailPage(),
        "resetPasswordPage": (context) => ResetPasswordPage(),
        "home": (context) => Home(),
        // "item": (context) => ProductDetail(),
        "cartPage": (context) => CartPage(),
        "searchItem": (context) => SearchItemPage(),
        "profilePage": (context) => ProfilePage(),
        "orderPage": (context) => OrderPage(),
        "editNamePage": (context) => EditNamePage(),
        "listOrderPage": (context) => ListOrderPage(),
        "doneOrderPage": (context) => DoneOrderPage(),
        "shippingPage": (context) => ShippingPage(),
        "processingPage": (context) => ProcessingPage(),
        "ratingPage": (context) => RatingPage(),
        "yourRatingPage": (context) => YourRatingPage(),
        // "editEmailPage": (context) => EditEmailPage(),
        // "editPhonePage": (context) => EditPhonePage(),
        "writeRatingPage": (context) => WriteRatingPage(),
        "orderDetailPage": (context) => DetailOrdered(),
        // "adminPage": (context) => HomeAdmin(),
      },
    );
  }
}
