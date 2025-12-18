import 'promotion.dart';

class PromotionListResponse {
  final List<Promotion> listPromotion;

  PromotionListResponse({required this.listPromotion});

  factory PromotionListResponse.fromJson(Map<String, dynamic> json) {
    return PromotionListResponse(
      listPromotion: (json["listPromotion"] as List)
          .map((e) => Promotion.fromJson(e))
          .toList(),
    );
  }
}
