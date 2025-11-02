import 'dart:convert';
import 'package:http/http.dart' as http;

class Summary {
  final int totalOrders;
  final int totalQuantity;
  final int totalAmount;

  Summary({
    required this.totalOrders,
    required this.totalQuantity,
    required this.totalAmount,
  });

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalOrders: json['totalOrders'],
      totalQuantity: json['totalQuantity'],
      totalAmount: json['totalAmount'],
    );
  }
}
