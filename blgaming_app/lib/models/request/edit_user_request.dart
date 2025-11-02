class EditUserRequest {
  final String userId;
  final String fullName;
  final String phone;

  EditUserRequest({
    required this.userId,
    required this.fullName,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'fullName': fullName, 'phone': phone};
  }
}
