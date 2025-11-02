class EditUserResponse {
  final String status;
  final String message;

  EditUserResponse({required this.status, required this.message});

  factory EditUserResponse.fromJson(Map<String, dynamic> json) {
    return EditUserResponse(
      status: json['status'] ?? 'error',
      message: json['message'] ?? '',
    );
  }
}
