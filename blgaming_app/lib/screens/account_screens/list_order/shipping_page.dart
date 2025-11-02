import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/response/order_response.dart';
import 'package:blgaming_app/screens/account_screens/profile/widgets/app_bar_profile.dart';
import 'package:blgaming_app/screens/home_screens/widgets/app_bar_cart_custom.dart';
import 'package:blgaming_app/services/order_service.dart';
import 'package:blgaming_app/ui_value.dart';

class ShippingPage extends StatefulWidget {
  const ShippingPage({super.key});

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  late Future<List<OrderResponse>> futureOrders;

  @override
  void initState() {
    super.initState();
    futureOrders = OrderService().getOrdersByUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarProfile(name: "Đơn hàng đang vận chuyển"),
      body: FutureBuilder<List<OrderResponse>>(
        future: futureOrders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Lỗi: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Đơn hàng trống",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }

          final orders = snapshot.data!
              .where((order) => order.status == "Đang vận chuyển")
              .toList();

          if (orders.isEmpty) {
            return Scaffold(
              body: Center(
                child: Text(
                  "Đơn hàng trống",
                  style: TextStyle(
                    color: textColor1,
                    fontFamily: "LD",
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(7),
                  ),

                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        "orderDetailPage",
                        arguments: order.id,
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Người nhận: ${order.receiveName}",
                          style: TextStyle(
                            color: textColor3,
                            fontFamily: "LD",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Nơi nhận: ${order.receiveAddress}",
                          style: TextStyle(
                            color: textColor3,
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
                              "Giá tiền: ${NumberFormat("#,###", "vi_VN").format(order.totalPrice)}",
                              style: TextStyle(
                                color: textColor3,
                                fontFamily: "LD",
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${order.status}",
                              style: TextStyle(
                                color: textColor3,
                                fontFamily: "LD",
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Text(
                              "Ngày đặt hàng: ${DateFormat('dd/MM/yyyy').format(order.createdAt)}",
                              style: TextStyle(
                                color: textColor3,
                                fontFamily: "LD",
                                fontSize: 13,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            //ElevatedButton(
                            // onPressed: () async {
                            //   bool success = await OrderService()
                            //       .markOrderDone(order.id);

                            //   if (success) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: Row(
                            //           children: [
                            //             Icon(
                            //               Icons.download_done_rounded,
                            //               color: white,
                            //             ),
                            //             const SizedBox(width: 12),
                            //             Expanded(
                            //               child: Text(
                            //                 "Xác nhận đơn hàng thành công",
                            //                 style: TextStyle(
                            //                   fontFamily: "LD",
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         backgroundColor: textColor1,
                            //         behavior: SnackBarBehavior.floating,
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //         ),
                            //         margin: const EdgeInsets.all(30),
                            //         duration: const Duration(seconds: 1),
                            //         elevation: 8,
                            //       ),
                            //     );
                            //     setState(() {
                            //       futureOrders = OrderService()
                            //           .getOrdersByUserId();
                            //     });
                            //   } else {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //         content: Row(
                            //           children: [
                            //             Icon(
                            //               Icons.error_outline,
                            //               color: white,
                            //             ),
                            //             const SizedBox(width: 12),
                            //             Expanded(
                            //               child: Text(
                            //                 "Xác nhận đơn hàng thất bại",
                            //                 style: TextStyle(
                            //                   fontFamily: "LD",
                            //                 ),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //         backgroundColor: textColor1,
                            //         behavior: SnackBarBehavior.floating,
                            //         shape: RoundedRectangleBorder(
                            //           borderRadius: BorderRadius.circular(10),
                            //         ),
                            //         margin: const EdgeInsets.all(30),
                            //         duration: const Duration(seconds: 1),
                            //         elevation: 8,
                            //       ),
                            //     );
                            //   }
                            // },
                            // child: Text(
                            //   "Đã nhận hàng",
                            //   style: TextStyle(
                            //     color: mainColor,
                            //     fontFamily: "LD",
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.bold,
                            //   ),
                            // ),
                            // style: ElevatedButton.styleFrom(
                            //   backgroundColor: white,
                            //   elevation: 0,
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(12),
                            //   ),
                            //   side: BorderSide(
                            //     // Viền
                            //     color: mainColor,
                            //     width: 1,
                            //   ),
                            // ),
                            //),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
