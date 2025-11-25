class BigSaleItem {
  final int id;
  final int gameId;
  final String gameName;
  final String imageUrl;
  final double originalPrice;
  final double salePrice;
  final int discountPercent;
  final int stock;

  BigSaleItem({
    required this.id,
    required this.gameId,
    required this.gameName,
    required this.imageUrl,
    required this.originalPrice,
    required this.salePrice,
    required this.discountPercent,
    required this.stock,
  });

  factory BigSaleItem.fromJson(Map<String, dynamic> json) {
    return BigSaleItem(
      id: json['id'] ?? 0,
      gameId: json['gameId'] ?? 0,
      gameName: (json['gameName'] ?? "").toString(),
      imageUrl: (json['imageUrl'] ?? "").toString(),
      originalPrice: (json['originalPrice'] ?? 0).toDouble(),
      salePrice: (json['salePrice'] ?? 0).toDouble(),
      discountPercent: json['discountPercent'] ?? 0,
      stock: json['stock'] ?? 0,
    );
  }
}
