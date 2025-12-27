class OrderCreateRequest {
  final String userId;
  final List<GameOrderItem> gameList;
  final List<int> promotionList;
  final double discountPrice;
  final double originalPrice;
  final double finalPrice;

  OrderCreateRequest({
    required this.userId,
    required this.gameList,
    required this.promotionList,
    required this.discountPrice,
    required this.originalPrice,
    required this.finalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "gameList": gameList.map((e) => e.toJson()).toList(),
      "promotionList": promotionList,
      "discountPrice": discountPrice,
      "originalPrice": originalPrice,
      "finalPrice": finalPrice,
    };
  }
}

class GameOrderItem {
  final int gameId;
  final int quantityUserBuy;
  final double price;
  final String des;

  GameOrderItem({
    required this.gameId,
    required this.quantityUserBuy,
    required this.price,
    required this.des,
  });

  Map<String, dynamic> toJson() {
    return {
      "gameId": gameId,
      "quantityUserBuy": quantityUserBuy,
      "price": price,
      "des": des,
    };
  }
}
