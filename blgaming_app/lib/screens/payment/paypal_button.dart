import 'package:blgaming_app/screens/payment/paypal_view.dart';
import 'package:flutter/material.dart';

class PaypalButton extends StatelessWidget {
  const PaypalButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => PaypalView(
              items: [
                //TODO: Replace with actual items
                PaypalItem(name: "Item 1", quantity: 1, price: 10.0),
                PaypalItem(name: "Item 2", quantity: 2, price: 15.5),
              ],
            ),
          ),
        );
      },
      child: Image.asset(
        "assets/imgs/paypal.png",
        height: 30,
        width: 30,
      ),
    );
  }
}
