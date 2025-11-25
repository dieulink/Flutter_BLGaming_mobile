class Product {
  final int id;
  final String name;
  final String imageUrl;
  final int price;
  final int stock;
  final int salePercent;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.stock,
    required this.salePercent,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String rawImage = json['img_link'] ?? '';

    if (rawImage.contains('/t_thumb/')) {
      rawImage = rawImage.replaceAll('/t_thumb/', '/t_1080p/');
    }

    return Product(
      id: json['game_id'] ?? 0,
      name: json['name'] ?? '',
      stock: json['in_stock'] ?? 0,
      salePercent: json['sale_percent'] ?? 0,
      imageUrl: rawImage,
      price: (json['price'] as num?)?.toInt() ?? 0,
    );
  }
}
