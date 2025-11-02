class Item {
  final int id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String descImages;
  final int stock;
  final double reviewScore;
  final int reviewCount;

  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.descImages,
    required this.stock,
    required this.reviewScore,
    required this.reviewCount,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    final detail = json['gameDetail'];

    String rawLinks = (detail['img_link'] ?? '').trim();

    List<String> allImages = rawLinks
        .split(',')
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .map((e) => e.replaceAll('/t_thumb/', '/t_1080p/'))
        .toList();

    final String mainImage = allImages.isNotEmpty ? allImages.first : '';

    final String descImages = allImages.join(',');

    return Item(
      id: detail['game_id'] ?? 0,
      name: detail['name'] ?? '',
      description: detail['description'] ?? '',
      price: double.tryParse(detail['price'].toString()) ?? 0.0,

      imageUrl: mainImage,
      descImages: descImages,
      stock: detail['in_stock'] ?? 0,
      reviewScore: (detail['review_score'] as num?)?.toDouble() ?? 0.0,
      reviewCount: detail['review_count'] ?? 0,
    );
  }
}
