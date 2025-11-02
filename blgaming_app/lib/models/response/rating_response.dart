class RatingResponse {
  final int id; // review_id
  final String userName; // full_name
  final int score; // score
  final String comment; // comment
  final DateTime createdAt; // create_date

  RatingResponse({
    required this.id,
    required this.userName,
    required this.score,
    required this.comment,
    required this.createdAt,
  });

  factory RatingResponse.fromJson(Map<String, dynamic> json) {
    return RatingResponse(
      id: json['review_id'] ?? 0,
      userName: json['full_name'] ?? 'Ẩn danh',
      score: json['score'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['create_date']),
    );
  }
}
