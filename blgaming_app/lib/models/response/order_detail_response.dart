class OrderDetailResponse {
  final int productId;
  final int productPrice;
  final String productName;
  final String? imageUrl;
  final int quantity;

  OrderDetailResponse({
    required this.productId,
    required this.productPrice,
    required this.quantity,
    required this.productName,
    required this.imageUrl,
  });

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponse(
      productName: json['productName'],
      imageUrl: json['productImage'],
      productId: json['productId'],
      productPrice: json['productPrice'],
      quantity: json['quantity'],
    );
  }
}
