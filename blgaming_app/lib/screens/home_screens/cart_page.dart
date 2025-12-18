import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/response/cart_response.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_cart_custom.dart';
import 'package:blgaming_app/screens/home_screens/widgets/item_cart.dart';
import 'package:blgaming_app/services/cart_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  CartResponse? cartResponse;
  bool isLoading = true;
  Set<int> selectedGameIds = {};
  double totalPrice = 0;
  int totalQuantity = 0;
  double totalBigSaleDiscount = 0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');

    if (userId == null || userId.isEmpty) {
      print(" userId not found in SharedPreferences");
      return;
    }

    final response = await CartService.fetchCart(userId);
    setState(() {
      cartResponse = response;
      isLoading = false;
      updateTotals();
    });
  }

  void updateTotals() {
    if (cartResponse == null) return;

    final selectedItems = cartResponse!.cartItems
        .where((item) => selectedGameIds.contains(item.gameId))
        .toList();

    double totalAfterSale = 0;
    double totalDiscount = 0;
    int quantity = 0;

    for (final item in selectedItems) {
      final double originalPrice = item.price;
      final double priceAfterSale =
          originalPrice * (100 - item.salePercent) / 100;

      totalAfterSale += priceAfterSale * item.quantity;
      totalDiscount += (originalPrice - priceAfterSale) * item.quantity;

      quantity += item.quantity;
    }

    setState(() {
      totalPrice = totalAfterSale;
      totalBigSaleDiscount = totalDiscount;
      totalQuantity = quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBarCartCustom(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (cartResponse == null || cartResponse!.cartItems.isEmpty) {
      return Scaffold(
        appBar: AppBarCartCustom(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 10),
                child: Image.asset("assets/imgs/chatbot5.gif", height: 100),
              ),
              Text(
                "Không có sản phẩm",
                style: TextStyle(fontFamily: "LD", color: white, fontSize: 13),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBarCartCustom(),
      body: ListView.builder(
        itemCount: cartResponse!.cartItems.length,
        itemBuilder: (context, index) {
          final item = cartResponse!.cartItems[index];
          return Column(
            children: [
              Container(height: 1, color: backgroudColor),
              CheckboxListTile(
                value: selectedGameIds.contains(item.gameId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedGameIds.add(item.gameId);
                    } else {
                      selectedGameIds.remove(item.gameId);
                    }
                    updateTotals();
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                activeColor: mainColor,
                checkColor: Colors.white,
                title: ItemCart(
                  imgPath: item.imageUrl,
                  name: item.name,
                  price: item.price.toInt(),
                  quantity: item.quantity,
                  productId: item.gameId,
                  salePercent: item.salePercent,
                  onDeleteSuccess: () async {
                    await loadCart();
                  },
                  onIncreaseSuccess: () async {
                    await loadCart();
                  },
                  onDecreaseSuccess: () async {
                    await loadCart();
                  },
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(5),
        height: 70,
        decoration: BoxDecoration(
          color: mainColor2,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Tổng tạm tính",
                      style: TextStyle(
                        color: white,
                        fontFamily: "LD",
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      NumberFormat.currency(
                        locale: 'vi_VN',
                        symbol: 'vn₫',
                      ).format(totalPrice),
                      style: TextStyle(
                        color: red,
                        fontFamily: "LD",
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (totalBigSaleDiscount > 0)
                      Text(
                        "-${NumberFormat.currency(
                          locale: 'vi_VN',
                          symbol: 'vn₫',
                        ).format(totalBigSaleDiscount)}",
                        style: TextStyle(
                          color: textColor1,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 10),
                Container(
                  width: getWidth(context) * 0.35,
                  height: 50,
                  margin: const EdgeInsets.only(right: 20),
                  child: ElevatedButton(
                    onPressed: selectedGameIds.isEmpty
                        ? null
                        : () {
                            final selectedItems = cartResponse!.cartItems
                                .where(
                                  (item) =>
                                      selectedGameIds.contains(item.gameId),
                                )
                                .toList();

                            Navigator.pushNamed(
                              context,
                              "orderPage",
                              arguments: {
                                'items': selectedItems,
                                'totalPrice': totalPrice,
                                'totalQuantity': totalQuantity,
                                'isCart': 1,
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Đặt mua ($totalQuantity)",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "LD",
                        fontWeight: FontWeight.bold,
                        color: white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
