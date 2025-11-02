class AddCartRequest {
  final int id;
  final int userId;

  AddCartRequest({required this.id, required this.userId});

  Map<String, dynamic> toJson() {
    return {'id': id, 'userId': userId};
  }
}
