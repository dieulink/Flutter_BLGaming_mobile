import 'package:blgaming_app/screens/home_screens/widgets/app_bar_promo.dart';
import 'package:flutter/material.dart';
import 'package:blgaming_app/models/response/promotion.dart';
import 'package:blgaming_app/ui_value.dart';

class PromoDetailPage extends StatelessWidget {
  final Promotion promo;

  const PromoDetailPage({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0E0E0E),
      appBar: AppBarPromo(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderImage(),
            _buildMainCard(context),
            const SizedBox(height: 20),
            _buildUseButton(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      width: double.infinity,
      height: 170,
      margin: EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/imgs/voucher2.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildMainCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: const Color(0xff1A1A1A),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            promo.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),

          // Giá trị giảm
          Row(
            children: [
              Icon(Icons.card_giftcard, color: mainColor, size: 22),
              const SizedBox(width: 8),
              Text(
                "Giảm ${promo.value.toStringAsFixed(0)}đ",
                style: TextStyle(
                  color: mainColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          _infoRow(
            "Đơn tối thiểu",
            "${promo.minOrderValue.toStringAsFixed(0)}đ",
          ),

          const SizedBox(height: 8),

          _infoRow(
            "Hiệu lực",
            "${promo.startDate.toString().substring(0, 10)} → ${promo.endDate.toString().substring(0, 10)}",
          ),

          const SizedBox(height: 20),
          const Divider(color: Colors.white24, thickness: 1),
          const SizedBox(height: 20),

          const Text(
            "Chi tiết & điều kiện sử dụng",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "• Áp dụng cho tất cả sản phẩm thuộc BL-Gaming.\n"
            "• Không áp dụng đồng thời với một số chương trình Big Sale.\n"
            "• Mỗi người dùng chỉ sử dụng 1 lần.\n"
            "• Voucher không có giá trị quy đổi thành tiền.",
            style: TextStyle(
              color: Colors.white.withOpacity(0.85),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUseButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, "cartPage");
      },
      child: const Text(
        "Sử dụng ngay",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
