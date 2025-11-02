class ProductCategory {
  final int id;
  final String name;
  final String imageUrl;
  final String? publicId;

  ProductCategory({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.publicId,
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    return ProductCategory(
      id: json['category_id'] ?? 0,
      name: json['category_name'] ?? '',
      imageUrl: json['category_img'] ?? '',
      publicId: json['public_id'],
    );
  }
}
