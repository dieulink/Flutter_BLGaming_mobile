class UserRevenue {
  final int userId;
  final String userName;
  final int orderCount;
  final int productCount;
  final double totalPrice;

  UserRevenue({
    required this.userId,
    required this.userName,
    required this.orderCount,
    required this.productCount,
    required this.totalPrice,
  });

  factory UserRevenue.fromJson(Map<String, dynamic> json) {
    return UserRevenue(
      userId: json['userId'],
      userName: json['userName'],
      orderCount: json['orderCount'],
      productCount: json['productCount'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
    );
  }
}
