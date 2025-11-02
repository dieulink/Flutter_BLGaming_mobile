class CartItemModel {
  final int gameId;
  final String name;
  final String imageUrl;
  final double price;
  final int inStock;
  final int quantity;

  CartItemModel({
    required this.gameId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.inStock,
    required this.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      gameId: json['game_id'] ?? 0,
      name: json['name'] ?? '',
      imageUrl: json['img_link'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      inStock: (json['in_stock'] as num?)?.toInt() ?? 0,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
    );
  }
}
