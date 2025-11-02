class EditAddressRequest {
  final int id;
  final String newAddress;

  EditAddressRequest({required this.id, required this.newAddress});

  Map<String, dynamic> toJson() => {'id': id, 'newAddress': newAddress};
}
