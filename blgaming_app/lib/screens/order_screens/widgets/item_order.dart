import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/ui_value.dart';

class ItemOrder extends StatelessWidget {
  final String imgPath;
  final String name;
  final double price;
  final int quantity;
  final int productId;
  final int salePercent;

  const ItemOrder({
    super.key,
    required this.imgPath,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
    required this.salePercent,
  });

  double get priceAfterSale => price - price * (salePercent / 100);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: mainColor2,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            children: [
              Image.network(
                imgPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    Image.asset("assets/imgs/default.jpg"),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: "LD",
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              NumberFormat("#,###", "vi_VN")
                                  .format(priceAfterSale),
                              style: const TextStyle(
                                fontFamily: "LD",
                                fontWeight: FontWeight.bold,
                                color: red,
                                fontSize: 12,
                              ),
                            ),
                            if (salePercent > 0)
                              Text(
                                NumberFormat("#,###", "vi_VN").format(price),
                                style: const TextStyle(
                                  fontFamily: "LD",
                                  fontSize: 11,
                                  color: textColor2,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          "x $quantity",
                          style: const TextStyle(
                            fontSize: 13,
                            color: white,
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
        Container(height: 1, color: borderColor),
      ],
    );
  }
}
