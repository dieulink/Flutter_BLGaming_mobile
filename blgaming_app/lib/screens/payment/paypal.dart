import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaypalItem {
  final String name;
  final int quantity;
  final double price;
  final String currency;

  PaypalItem({
    required this.name,
    required this.quantity,
    required this.price,
    this.currency = "USD",
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "quantity": quantity,
      "price": price.toStringAsFixed(2),
      "currency": currency,
    };
  }
}

class Paypal extends StatelessWidget {
  final List<PaypalItem> items;
  const Paypal({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double totalAmount =
        items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    String totalStr = totalAmount.toStringAsFixed(2);
    List<Map<String, dynamic>> itemsListMap =
        items.map((item) => item.toJson()).toList();
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId:
          "AZNce76doknZSbOMHGZ9xlF7FvivyTpUfTnv90xnJsfMaE5fTFB4ts0imfxa7fgR_VwSFfmKlVhuvEgh",
      secretKey:
          "EA_67JEE7XIF5waP_nforeWavioEhw0l3VzKqzsoC6_l61M20IAZgzfa3lNaMA5GjqRYuk0GJA4r3IXO",
      transactions: [
        {
          "amount": {
            "total": totalStr,
            "currency": "USD",
            "details": {
              "subtotal": totalStr,
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "Thanh toán đơn hàng từ BLGaming",
          "item_list": {
            "items": itemsListMap,
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        print("onSuccess: $params");
        Navigator.pop(context);
      },
      onError: (error) {
        print("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        print('cancelled:');
      },
    );
  }
}
