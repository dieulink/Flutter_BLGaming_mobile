import 'package:blgaming_app/models/response/cart_item_model.dart';

class CartResponse {
  final List<CartItemModel> cartItems;

  CartResponse({required this.cartItems});

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    final items = (json['cartList'] as List<dynamic>? ?? [])
        .map((item) => CartItemModel.fromJson(item))
        .toList();

    return CartResponse(cartItems: items);
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);

  int get totalQuantity =>
      cartItems.fold(0, (sum, item) => sum + item.quantity);
}
