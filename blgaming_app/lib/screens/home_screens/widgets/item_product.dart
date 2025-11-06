import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/models/request/add_cart_request.dart';
import 'package:blgaming_app/models/response/product.dart';
import 'package:blgaming_app/screens/home_screens/product_detail.dart';
import 'package:blgaming_app/services/cart_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:blgaming_app/screens/home_screens/widgets/item_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemProduct extends StatelessWidget {
  final Product product;

  const ItemProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ProductDetail(id: product.id),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
          ),
        );
      },

      child: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: itemColor,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.vertical(
                top: Radius.circular(10),
              ),
              child: Image.network(
                product.imageUrl,
                height: 150,
                width: getWidth(context),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/imgs/default.png',
                    height: 150,
                    width: getWidth(context),
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                product.name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "LD",
                  //fontWeight: FontWeight.bold,
                  color: white,
                  fontSize: 14,
                ),
              ),
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // RatingBarIndicator(
                //   rating: 4.5, // số sao muốn hiển thị
                //   itemBuilder: (context, index) =>
                //       Icon(Icons.star, color: Colors.amber),
                //   itemCount: 5,
                //   itemSize: 15.0, // kích thước sao
                //   direction: Axis.horizontal,
                // ),
                // SizedBox(width: 5),
                // SizedBox(
                //   child: Container(height: 15, width: 1, color: textColor2),
                // ),
                // SizedBox(width: 5),
                // Text(
                //   "Còn ${product.stock} sản phẩm",
                //   style: TextStyle(color: textColor2, fontSize: 12),
                // ),
              ],
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${NumberFormat("#,###", "vi_VN").format(product.price)} vnđ",
                    style: const TextStyle(
                      fontFamily: "LD",
                      fontWeight: FontWeight.bold,
                      color: mainColor,
                      fontSize: 12,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final userId = prefs.getString('userId');

                      if (userId == null || userId.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              "Vui lòng đăng nhập để thêm vào giỏ hàng!",
                            ),
                            backgroundColor: Colors.redAccent,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(20),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        return;
                      }

                      final response = await CartService.updateCartQuantity(
                        gameId: product.id,
                        userId: userId,
                        quantity: 1, // mỗi lần bấm thêm 1 sản phẩm
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(
                                response != null
                                    ? Icons.check_circle_outline
                                    : Icons.error_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  response != null
                                      ? "Đã thêm 1 sản phẩm vào giỏ hàng"
                                      : "Thêm vào giỏ hàng thất bại",
                                  style: const TextStyle(fontFamily: "LD"),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: response != null
                              ? Colors.green
                              : Colors.redAccent,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          margin: const EdgeInsets.all(20),
                          duration: const Duration(seconds: 1),
                          elevation: 8,
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.shopping_cart_checkout_outlined,
                      color: mainColor,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
