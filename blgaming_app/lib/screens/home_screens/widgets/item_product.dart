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
      onTap: () async {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) =>
              const Center(child: CircularProgressIndicator(color: mainColor)),
        );
        await Future.delayed(const Duration(milliseconds: 700));
        Navigator.pop(context);
        if (context.mounted) {
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
        }
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
            Stack(
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
                        'assets/imgs/default.jpg',
                        height: 150,
                        width: getWidth(context),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
                product.salePercent > 0
                    ? Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          decoration: BoxDecoration(
                            color: red,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 5,
                          ),
                          child: Text(
                            "- ${product.salePercent} %",
                            style: TextStyle(
                              color: white,
                              fontFamily: "LD",
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      )
                    : Container(),
              ],
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
                  fontSize: 13,
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
            product.salePercent > 0
                ? Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "${NumberFormat("#,###", "vi_VN").format(product.price)} vnđ",
                          style: TextStyle(
                            color: mainColor,
                            fontSize: 13,
                            fontFamily: "LD",
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1.5,
                            decorationColor: textColor1,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${NumberFormat("#,###", "vi_VN").format(product.price * (100 - product.salePercent) / 100)} vnđ",
                              style: const TextStyle(
                                fontFamily: "LD",
                                fontWeight: FontWeight.bold,
                                color: red,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(
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
            SizedBox(height: 5),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Chỉ còn ${product.stock} ",
                style: TextStyle(color: white, fontSize: 10, fontFamily: "LD"),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
