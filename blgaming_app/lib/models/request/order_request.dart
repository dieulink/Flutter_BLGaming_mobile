import 'order_detail_request.dart';

class OrderRequest {
  final int userId;
  final int quantity;
  final int totalPrice;
  final String receiveAddress;
  final String receiveName;
  final String receivePhone;
  final int shipCost;
  final int isCart;
  final int payMethodId;
  final List<OrderDetailRequest> items;

  OrderRequest({
    required this.userId,
    required this.quantity,
    required this.totalPrice,
    required this.receiveAddress,
    required this.receiveName,
    required this.receivePhone,
    required this.shipCost,
    required this.isCart,
    required this.payMethodId,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'quantity': quantity,
    'totalPrice': totalPrice,
    'receiveAddress': receiveAddress,
    'receiveName': receiveName,
    'receivePhone': receivePhone,
    'shipCost': shipCost,
    'isCart': isCart,
    'payMethodId': payMethodId,
    'items': items.map((e) => e.toJson()).toList(),
  };
}
