import 'order_detail_response.dart';

class OrderResponse {
  final int id;
  final int userId;
  final int quantity;
  final int totalPrice;
  final String receiveAddress;
  final String receiveName;
  final String receivePhone;
  final int shipCost;
  final String status;
  final int payMethodId;
  final DateTime createdAt;
  final DateTime doneAt;
  final List<OrderDetailResponse> items;

  OrderResponse({
    required this.id,
    required this.userId,
    required this.quantity,
    required this.totalPrice,
    required this.receiveAddress,
    required this.receiveName,
    required this.receivePhone,
    required this.shipCost,
    required this.status,
    required this.payMethodId,
    required this.items,
    required this.createdAt,
    required this.doneAt,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      id: json['orderId'],
      userId: json['userId'],
      quantity: json['quantity'],
      totalPrice: json['totalPrice'],
      receiveAddress: json['receiveAddress'],
      receiveName: json['receiveName'],
      receivePhone: json['receivePhone'],
      shipCost: json['shipCost'],
      status: json['status'],
      payMethodId: json['payMethodId'],
      items: (json['items'] as List)
          .map((item) => OrderDetailResponse.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      doneAt: json['doneAt'] != null
          ? DateTime.parse(json['doneAt'])
          : DateTime(0, 0, 0),
    );
  }
}
