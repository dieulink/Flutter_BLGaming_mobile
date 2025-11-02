class OrderDetailRequest {
  final int productId;
  final double productPrice;
  final int quantity;

  OrderDetailRequest({
    required this.productId,
    required this.productPrice,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'productPrice': productPrice,
    'quantity': quantity,
  };
}
