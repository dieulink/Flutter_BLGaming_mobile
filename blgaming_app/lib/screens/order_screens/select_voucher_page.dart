import 'package:blgaming_app/models/response/promotion.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_voucher.dart';
import 'package:blgaming_app/services/promotion_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';

class SelectVoucherPage extends StatefulWidget {
  const SelectVoucherPage({super.key});

  @override
  State<SelectVoucherPage> createState() => _SelectVoucherPageState();
}

class _SelectVoucherPageState extends State<SelectVoucherPage> {
  int selectedIndex = 0;

  late Future<List<Promotion>> promotionsFuture;
  late Future<List<Promotion>> userPromotionsFuture;

  @override
  void initState() {
    super.initState();
    promotionsFuture = PromotionService.fetchPromotions();
    userPromotionsFuture = PromotionService.fetchPromotionByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarVoucher(),
      body: Column(
        children: [
          _buildTopNavigation(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildTopNavigation() {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.3)),
      ),
      child: Row(
        children: [
          _navItem("BL-Gaming", 0),
          _navItem("Dành cho bạn", 1),
        ],
      ),
    );
  }

  Widget _navItem(String label, int index) {
    final active = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: active
                ? const Border(
                    bottom: BorderSide(color: mainColor, width: 2),
                  )
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: active ? mainColor : Colors.grey,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final future = selectedIndex == 0 ? promotionsFuture : userPromotionsFuture;

    return Expanded(
      child: FutureBuilder<List<Promotion>>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Lỗi tải voucher"));
          }

          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return const Center(child: Text("Không có voucher"));
          }

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (_, index) {
              final promo = list[index];
              return _buildVoucherItem(promo);
            },
          );
        },
      ),
    );
  }

  Widget _buildVoucherItem(Promotion promo) {
    return InkWell(
      onTap: () {
        // 🔥 TRẢ VỀ VOUCHER ĐƯỢC CHỌN
        Navigator.pop(context, promo);
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: mainColor2,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Image.asset("assets/imgs/voucher2.png", height: 80),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Giảm ${promo.value.toStringAsFixed(0)}đ",
                    style: const TextStyle(color: white),
                  ),
                  Text(
                    "Đơn tối thiểu ${promo.minOrderValue.toStringAsFixed(0)}đ",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.check_circle_outline, color: mainColor),
          ],
        ),
      ),
    );
  }
}
