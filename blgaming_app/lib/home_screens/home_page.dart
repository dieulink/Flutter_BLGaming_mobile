import 'package:blgaming_app/home_screens/widgets/custom_search_bar.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroudColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [CustomSearchBar(hintText: "Bạn muốn tìm gì ?")],
          ),
        ),
      ),
    );
  }
}
