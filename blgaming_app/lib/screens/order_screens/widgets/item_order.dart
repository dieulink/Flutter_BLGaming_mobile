import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blgaming_app/services/cart_service.dart';
import 'package:blgaming_app/ui_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItemOrder extends StatefulWidget {
  final String imgPath;
  final String name;
  final double price;
  final int quantity;
  final int productId;

  const ItemOrder({
    super.key,
    required this.imgPath,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
  });

  @override
  State<ItemOrder> createState() => _ItemOrderState();
}

class _ItemOrderState extends State<ItemOrder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: mainColor2,

            //border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                widget.imgPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset("assets/imgs/default.jpg");
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      //alignment: Alignment.centerLeft,
                      width: double.infinity,
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        widget.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: "LD",
                          fontWeight: FontWeight.bold,
                          color: white,
                          fontSize: 13,
                        ),
                        //textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "${NumberFormat("#,###", "vi_VN").format(widget.price)}",
                            style: TextStyle(
                              fontFamily: "LD",
                              fontWeight: FontWeight.bold,
                              color: mainColor3,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          padding: EdgeInsets.only(right: 10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              "x ${widget.quantity}",
                              style: const TextStyle(
                                fontSize: 13,
                                color: white,
                              ),
                            ),
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
