class ProductRevenue {
  final int productId;
  final String productName;
  final String imageUrl;
  final int totalSold;
  final double totalRevenue;

  ProductRevenue({
    required this.productId,
    required this.productName,
    required this.imageUrl,
    required this.totalSold,
    required this.totalRevenue,
  });

  factory ProductRevenue.fromJson(Map<String, dynamic> json) {
    return ProductRevenue(
      productId: json['productId'],
      productName: json['productName'],
      imageUrl: json['imageUrl'],
      totalSold: json['totalSold'],
      totalRevenue: (json['totalRevenue'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'imageUrl': imageUrl,
      'totalSold': totalSold,
      'totalRevenue': totalRevenue,
    };
  }
}
