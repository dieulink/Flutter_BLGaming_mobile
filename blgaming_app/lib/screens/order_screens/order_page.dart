import 'package:blgaming_app/models/request/order_create_request.dart';
import 'package:blgaming_app/models/response/promotion.dart';
import 'package:blgaming_app/screens/order_screens/select_voucher_page.dart';
import 'package:blgaming_app/screens/payment/paypal_webview.dart';
import 'package:blgaming_app/services/paypal_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/response/cart_item_model.dart';
import 'package:blgaming_app/screens/order_screens/widgets/app_bar_order.dart';
import 'package:blgaming_app/screens/order_screens/widgets/item_order.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blgaming_app/screens/payment/paypal_view.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String receiveName = "";
  String receivePhone = "";
  late String userId;
  Promotion? selectedVoucher;
  OrderCreateRequest _buildOrderRequest({
    required List<CartItemModel> items,
    required double originTotal,
    required double bigSaleDiscount,
    required double voucherDiscount,
  }) {
    return OrderCreateRequest(
      userId: userId,
      gameList: items.map((e) {
        return GameOrderItem(
          gameId: e.gameId,
          quantityUserBuy: e.quantity,
          price: e.price,
          des: e.name,
        );
      }).toList(),
      promotionList:
          selectedVoucher != null ? [selectedVoucher!.promotionId] : [],
      originalPrice: originTotal,
      discountPrice: bigSaleDiscount + voucherDiscount,
      finalPrice: (originTotal - bigSaleDiscount - voucherDiscount)
          .clamp(0, double.infinity),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      receiveName = prefs.getString('name') ?? '';
      receivePhone = prefs.getString('phone') ?? '';
      userId = prefs.getString('userId') ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return const Scaffold(
        body: Center(child: Text("Không có dữ liệu")),
      );
    }

    final List<CartItemModel> items =
        (args['items'] as List).cast<CartItemModel>();

    final int totalQuantity = args['totalQuantity'];
    final int isCart = args['isCart'];

    double originTotal = 0;
    double bigSaleDiscount = 0;

    for (final item in items) {
      final itemOriginTotal = item.price * item.quantity;
      final itemBigSale = item.price * item.salePercent / 100 * item.quantity;

      originTotal += itemOriginTotal;
      bigSaleDiscount += itemBigSale;
    }

    final double priceAfterBigSale = originTotal - bigSaleDiscount;

    final double voucherDiscount = (selectedVoucher != null &&
            priceAfterBigSale >= selectedVoucher!.minOrderValue)
        ? selectedVoucher!.value
        : 0;

    final double finalTotal = (priceAfterBigSale - voucherDiscount) > 0
        ? (priceAfterBigSale - voucherDiscount)
        : 0;

    return Scaffold(
      appBar: AppBarOrder(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: mainColor2,
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/imgs/user.png',
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        receiveName,
                        style: const TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        receivePhone,
                        style: const TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: mainColor2,
              ),
              child: Column(
                children: items.map((item) {
                  return ItemOrder(
                    imgPath: item.imageUrl ?? "assets/imgs/default.jpg",
                    name: item.name,
                    price: item.price,
                    quantity: item.quantity,
                    productId: item.gameId,
                    salePercent: item.salePercent,
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              width: getWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: mainColor2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                      color: white,
                      fontFamily: "LD",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PaypalView(
                                items: items.map((e) {
                                  return PaypalItem(
                                    name: e.name,
                                    quantity: e.quantity,
                                    price: e.price * (1 - e.salePercent / 100),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          "assets/imgs/paypal.png",
                          height: 35,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Thanh toán bằng PayPal",
                        style: TextStyle(color: white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(15),
              width: getWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: mainColor2,
              ),
              child: InkWell(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectVoucherPage(),
                    ),
                  );

                  if (result != null && result is Promotion) {
                    setState(() {
                      selectedVoucher = result;
                    });
                  }
                },
                child: Row(
                  children: [
                    Text(
                      selectedVoucher?.name ?? "Chọn Mã giảm giá",
                      style: const TextStyle(
                        color: mainColor,
                        fontSize: 13,
                        fontFamily: "LD",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.navigate_next_rounded,
                      color: mainColor,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.all(15),
              width: getWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: mainColor2,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Chi tiết đơn hàng",
                    style: TextStyle(
                      color: white,
                      fontFamily: "LD",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _priceRow(
                    "Tổng tiền hàng",
                    originTotal,
                  ),
                  _priceRow(
                    "Giảm BigSale",
                    -bigSaleDiscount,
                  ),
                  _priceRow(
                    "Giảm Voucher",
                    -voucherDiscount,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5),
        height: 70,
        decoration: BoxDecoration(
          color: mainColor2,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Tổng thanh toán",
                  style: TextStyle(
                    color: white,
                    fontFamily: "LD",
                    fontSize: 13,
                  ),
                ),
                Text(
                  NumberFormat("#,###", "vi_VN").format(finalTotal),
                  style: const TextStyle(
                    color: red,
                    fontFamily: "LD",
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Container(
              width: getWidth(context) * 0.3,
              height: 50,
              margin: const EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  final orderRequest = _buildOrderRequest(
                    items: items,
                    originTotal: originTotal,
                    bigSaleDiscount: bigSaleDiscount,
                    voucherDiscount: voucherDiscount,
                  );
                  print(orderRequest.toJson());
                  final redirectLink = await PaypalService.createPayment(
                      body: orderRequest.toJson());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaypalWebViewPage(
                        approvalUrl: redirectLink,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Đặt hàng",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String title, double value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: white, fontSize: 12),
          ),
          Text(
            "${value < 0 ? '-' : ''}${NumberFormat("#,###", "vi_VN").format(value.abs())}",
            style: const TextStyle(
              color: white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
