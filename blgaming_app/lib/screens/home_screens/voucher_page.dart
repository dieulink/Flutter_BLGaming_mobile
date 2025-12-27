import 'package:blgaming_app/models/response/promotion.dart';
import 'package:blgaming_app/screens/home_screens/promo_detail_page.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_voucher.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:flutter/material.dart';
import '../../services/promotion_service.dart';

class VoucherPage extends StatefulWidget {
  const VoucherPage({super.key});

  @override
  State<VoucherPage> createState() => _VoucherPageState();
}

class _VoucherPageState extends State<VoucherPage> {
  int selectedIndex = 0;

  late Future<List<Promotion>> promotionsFuture; // Tất cả voucher
  late Future<List<Promotion>> userPromotionsFuture; // Voucher theo userId
  late Future<List<Promotion>> upcomingPromotionsFuture;

  @override
  void initState() {
    super.initState();
    promotionsFuture = PromotionService.fetchPromotions();
    userPromotionsFuture = PromotionService.fetchPromotionByUserId();
    upcomingPromotionsFuture = PromotionService.fetchUpcomingPromotions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarVoucher(),
      body: Column(children: [_buildTopNavigation(), _buildContent()]),
    );
  }

  Widget _buildTopNavigation() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        border: const Border(
          bottom: BorderSide(color: Colors.grey, width: 0.3),
        ),
        color: backgroudColor,
      ),
      child: Row(
        children: [
          _navItem("BL-Gaming", 0),
          _navItem("Dành cho bạn", 1),
          _navItem("Sắp diễn ra", 2),
        ],
      ),
    );
  }

  Widget _navItem(String label, int index) {
    final bool active = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedIndex = index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: active
                ? const Border(bottom: BorderSide(color: mainColor, width: 2))
                : null,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            label,
            style: TextStyle(
              color: active ? mainColor : Colors.grey,
              fontSize: 15,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (selectedIndex) {
      case 0:
        return Expanded(child: _buildPromotionList(promotionsFuture));
      case 1:
        return Expanded(child: _buildPromotionList(userPromotionsFuture));
      case 2:
        return Expanded(child: _buildPromotionList(upcomingPromotionsFuture));
      default:
        return const SizedBox();
    }
  }

  Widget _buildPromotionList(Future<List<Promotion>> future) {
    return FutureBuilder<List<Promotion>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text("Lỗi tải voucher"));
        }

        final list = snapshot.data ?? [];

        if (list.isEmpty) {
          return const Center(
              child: Text(
            "Không có voucher",
            style: TextStyle(color: white),
          ));
        }

        return ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final promo = list[index];
            return _buildPromotionItem(promo);
          },
        );
      },
    );
  }

  Widget _buildPromotionItem(Promotion promo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: mainColor2,
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            child: Image.asset("assets/imgs/voucher2.png", height: 100),
          ),
          const SizedBox(width: 20),
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
                  "Giảm: ${promo.value.toStringAsFixed(0)}đ",
                  style: const TextStyle(fontSize: 13, color: white),
                ),
                const SizedBox(height: 4),
                Text(
                  "Đơn tối thiểu: ${promo.minOrderValue.toStringAsFixed(0)}đ",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(204, 255, 254, 254),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "HSD: ${promo.startDate.toString().substring(0, 10)} - ${promo.endDate.toString().substring(0, 10)}",
                  style: const TextStyle(
                    color: Color.fromARGB(176, 255, 254, 254),
                    fontSize: 12,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PromoDetailPage(promo: promo),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 5, bottom: 5),
                    child: Text("Xem chi tiết >",
                        style: const TextStyle(
                          color: mainColor,
                          fontSize: 13,
                          //fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
