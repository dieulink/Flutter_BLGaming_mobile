import 'package:flutter/material.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:blgaming_app/ui_value.dart';

class ListOrderPage extends StatelessWidget {
  ListOrderPage({super.key});

  // ------------------------------------------------------------------
  // DỮ LIỆU GAME + ACCOUNT (GEN TRONG 1 FILE)
  // ------------------------------------------------------------------

  final List<String> gameNames = const [
    "GTA V",
    "Minecraft",
    "PUBG Mobile",
    "Valorant",
    "Red Dead Redemption 2",
  ];

  // Hàm tạo 5 tài khoản mẫu
  List<Map<String, String>> _generateAccounts() {
    List<Map<String, String>> data = [];
    for (int i = 0; i < 5; i++) {
      data.add({
        "game": gameNames[i],
        "username": "user${i + 1}".padLeft(8, "0"),
        "password": "pass${i + 1}".padLeft(8, "0"),
      });
    }
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final accounts = _generateAccounts();

    return Scaffold(
      backgroundColor: backgroudColor,
      appBar: AppBarProfile(name: "Quản lý tài khoản game"),
      body: Column(
        children: [
          Container(
            height: 1,
            margin: const EdgeInsets.only(top: 40),
            color: borderColor,
          ),

          // ------------------ DANH SÁCH TÀI KHOẢN ------------------
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: accounts.length,
              itemBuilder: (context, index) {
                final acc = accounts[index];
                return _buildAccountCard(acc);
              },
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // UI CARD HIỂN THỊ TÀI KHOẢN GAME
  // ------------------------------------------------------------------
  Widget _buildAccountCard(Map<String, String> acc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: mainColor2,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TÊN GAME
          Row(
            children: [
              const Icon(Icons.sports_esports, color: Colors.white70),
              const SizedBox(width: 10),
              Text(
                acc["game"]!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // USERNAME
          Row(
            children: [
              const Icon(Icons.person, color: Colors.white70),
              const SizedBox(width: 10),
              Text(
                acc["username"]!,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // PASSWORD
          Row(
            children: [
              const Icon(Icons.lock, color: Colors.white70),
              const SizedBox(width: 10),
              Text(
                acc["password"]!,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
