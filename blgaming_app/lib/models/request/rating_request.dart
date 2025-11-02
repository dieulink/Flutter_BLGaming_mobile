class RatingRequest {
  final int userId;
  final int productId;
  final int score;
  final String comment;

  RatingRequest({
    required this.userId,
    required this.productId,
    required this.score,
    required this.comment,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'productId': productId,
      'score': score,
      'comment': comment,
    };
  }
}
