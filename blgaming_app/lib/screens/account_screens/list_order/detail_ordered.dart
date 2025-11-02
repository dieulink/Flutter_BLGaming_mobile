import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/response/order_response.dart';
import 'package:blgaming_app/screens/order_screens/widgets/app_bar_order.dart';
import 'package:blgaming_app/screens/order_screens/widgets/item_order.dart';
import 'package:blgaming_app/services/order_service.dart';
import 'package:blgaming_app/ui_value.dart';

class DetailOrdered extends StatefulWidget {
  const DetailOrdered({super.key});

  @override
  State<DetailOrdered> createState() => _DetailOrderedState();
}

class _DetailOrderedState extends State<DetailOrdered> {
  final orderService = OrderService();
  OrderResponse? order;
  late int orderId;
  bool isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    orderId = ModalRoute.of(context)!.settings.arguments as int;
    print(orderId);
    _fetchOrderDetail();
  }

  Future<void> _fetchOrderDetail() async {
    try {
      final result = await OrderService().getOrdersByOrderId(orderId);
      setState(() {
        order = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print("Lỗi khi lấy đơn hàng: $e");
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (order == null) {
      return const Center(child: Text("Không tìm thấy đơn hàng"));
    }
    return Scaffold(
      //backgroundColor: white,
      appBar: AppBarOrder(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/system_icon/24px/Location.png',
                        color: mainColor,
                        height: 20,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${order?.receiveName}",
                            style: TextStyle(
                              color: textColor3,
                              fontFamily: "LD",
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${order?.receivePhone}",
                            style: TextStyle(
                              color: textColor3,
                              fontFamily: "LD",
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            "${order?.receiveAddress}",
                            style: TextStyle(
                              color: textColor3,
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
                children: order!.items.map((item) {
                  return ItemOrder(
                    imgPath: item.imageUrl ?? "assets/imgs/default.jpg",
                    name: item.productName,
                    price: item.productPrice.toDouble(),
                    quantity: item.quantity,
                    productId: item.productId,
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
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Phương thức thanh toán",
                    style: TextStyle(
                      color: textColor3,
                      fontFamily: "LD",
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   "Thanh toán khi nhận hàng",
                  //   style: TextStyle(
                  //     color: textColor3,
                  //     fontFamily: "LD",
                  //     fontSize: 12,
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(15),
              width: getWidth(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chi tiết đơn hàng",
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
                        "Tổng tiền hàng",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(order?.totalPrice)}",
                        style: TextStyle(
                          color: textColor3,
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
                        "Tổng tiền phí vận chuyển",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(order?.shipCost)}",
                        style: TextStyle(
                          color: textColor3,
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
                        "Tổng số lượng sản phẩm",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${order?.quantity}",
                        style: TextStyle(
                          color: textColor3,
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
                        "Trạng thái đơn hàng",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${order?.status}",
                        style: TextStyle(
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
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
                          color: textColor3,
                          fontFamily: "LD",
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${NumberFormat("#,###", "vi_VN").format(order!.totalPrice + 30000)}",
                        style: TextStyle(
                          color: textColor3,
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
    );
  }
}
