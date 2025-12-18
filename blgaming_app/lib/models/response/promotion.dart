class Promotion {
  final int promotionId;
  final double value;
  final DateTime startDate;
  final DateTime endDate;
  final double minOrderValue;
  final String name;

  Promotion({
    required this.promotionId,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.minOrderValue,
    required this.name,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) {
    return Promotion(
      promotionId: json['promotion_id'],
      value: (json['value'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      minOrderValue: (json['min_order_value'] as num).toDouble(),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'promotion_id': promotionId,
      'value': value,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'min_order_value': minOrderValue,
      'name': name,
    };
  }
}
