class RatingResponse {
  final int id;
  final String userId;
  final String userName;
  final int score;
  final String comment;
  final DateTime createdAt;

  RatingResponse({
    required this.id,
    required this.userId,
    required this.userName,
    required this.score,
    required this.comment,
    required this.createdAt,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      id: json['review_id'] as int,
      userId: json['user_id']?.toString() ?? '',
      userName: json['full_name']?.toString() ?? 'Ẩn danh',
      score: json['score'] as int? ?? 0,
      comment: json['comment']?.toString() ?? '',
      createdAt: json['create_date'] != null
          ? DateTime.parse(json['create_date'])
          : DateTime.now(),
    );
  }
}
