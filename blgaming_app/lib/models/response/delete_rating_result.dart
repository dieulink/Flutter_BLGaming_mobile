import 'package:blgaming_app/models/response/rating_response.dart';

class DeleteRatingResult {
  final List<RatingResponse> ratings;
  final String message;

  DeleteRatingResult({required this.ratings, required this.message});

  factory DeleteRatingResult.fromJson(Map<String, dynamic> json) {
    var ratingsList = (json['ratings'] as List)
        .map((e) => RatingResponse.fromJson(e))
        .toList();

    return DeleteRatingResult(
      ratings: ratingsList,
      message: json['message'] ?? '',
    );
  }
}
