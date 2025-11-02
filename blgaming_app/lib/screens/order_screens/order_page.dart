import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/request/order_detail_request.dart';
import 'package:blgaming_app/models/request/order_request.dart';
import 'package:blgaming_app/models/response/cart_item_model.dart';
import 'package:blgaming_app/screens/home_screens/widgets/item_cart.dart';
import 'package:blgaming_app/screens/order_screens/widgets/app_bar_order.dart';
import 'package:blgaming_app/screens/order_screens/widgets/item_order.dart';
import 'package:blgaming_app/services/order_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String receiveName = "";
  String receiveAddress = "";
  String receivePhone = "";
  late String userId;
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      receiveName = prefs.getString('name') ?? 'Không lấy được name';
      receivePhone = prefs.getString('phone') ?? 'Không lấy được sđt';
      userId = prefs.getString('userId') ?? '';
    });
  }

  Future<void> _loadReceiveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      receiveName = prefs.getString('receiveName') ?? "không có";
      receivePhone = prefs.getString('receivePhone') ?? "không có";
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      return Scaffold(body: Center(child: Text("Không có dữ liệu")));
    }

    final List<CartItemModel> items = (args['items'] as List)
        .map((e) => e as CartItemModel)
        .toList();
    final double totalPrice = args['totalPrice'];
    final int totalQuantity = args['totalQuantity'];
    final int isCart = args['isCart'];
    return Scaffold(
      appBar: AppBarOrder(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: mainColor2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/imgs/linhvat2.png', height: 50),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${receiveName}",
                            style: TextStyle(
                              color: white,
                              fontFamily: "LD",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "${receivePhone}",
                            style: TextStyle(
                              color: white,
                              fontFamily: "LD",
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                  SizedBox(height: 10),
                ],
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
                    "Chi tiết đơn hàng",
                    style: TextStyle(
                      color: white,
                      fontFamily: "LD",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng tiền hàng",
                        style: TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(totalPrice)}",
                        style: TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng giảm giá ",
                        style: TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 12,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),

                  Container(height: 1, color: backgroudColor),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tổng thanh toán",
                        style: TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(totalPrice)}",
                        style: TextStyle(
                          color: white,
                          fontFamily: "LD",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
                Text(
                  "Tổng cộng",
                  style: TextStyle(
                    color: white,
                    fontFamily: "LD",
                    fontSize: 13,
                  ),
                ),
                Text(
                  "${NumberFormat("#,###", "vi_VN").format(totalPrice + 30000)}",
                  style: TextStyle(
                    color: red,
                    fontFamily: "LD",
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 10),
            Container(
              width: getWidth(context) * 0.3,
              height: 50,
              margin: EdgeInsets.only(right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  // final orderService = OrderService();

                  // List<OrderDetailRequest> orderItems = items.map((item) {
                  //   return OrderDetailRequest(
                  //     productId: item.gameId,
                  //     productPrice: item.price,
                  //     quantity: item.quantity,
                  //   );
                  // }).toList();
                  // final request = OrderRequest(
                  //   userId: userId,
                  //   quantity: totalQuantity,
                  //   totalPrice: totalPrice,
                  //   receiveAddress: receiveAddress,
                  //   receiveName: receiveName,
                  //   receivePhone: receivePhone,
                  //   shipCost: 30000,
                  //   isCart: isCart,
                  //   payMethodId: 1,
                  //   items: orderItems,
                  // );
                  // bool success = await orderService.createOrder(request);
                  // if (success) {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Row(
                  //         children: [
                  //           Icon(Icons.download_done_rounded, color: mainColor2),
                  //           const SizedBox(width: 12),
                  //           Expanded(
                  //             child: Text(
                  //               "Đặt hàng thành công",
                  //               style: TextStyle(fontFamily: "LD"),
                  //             ),
                  //           ),
                  //         ],
                  //       ),

                  //       backgroundColor: textColor1,
                  //       behavior: SnackBarBehavior.floating,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       margin: const EdgeInsets.all(30),
                  //       duration: const Duration(seconds: 1),
                  //       elevation: 8,
                  //     ),
                  //   );
                  // } else {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(
                  //       content: Row(
                  //         children: [
                  //           Icon(Icons.error_outline, color: mainColor2),
                  //           const SizedBox(width: 12),
                  //           Expanded(
                  //             child: Text(
                  //               "Đặt hàng thất bại",
                  //               style: TextStyle(fontFamily: "LD"),
                  //             ),
                  //           ),
                  //         ],
                  //       ),

                  //       backgroundColor: textColor1,
                  //       behavior: SnackBarBehavior.floating,
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(10),
                  //       ),
                  //       margin: const EdgeInsets.all(30),
                  //       duration: const Duration(seconds: 1),
                  //       elevation: 8,
                  //     ),
                  //   );
                  // }
                  // Navigator.pushNamed(context, "home");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Đặt hàng",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
