class RegisterResponse {
  final String status;

  RegisterResponse({required this.status});

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(status: json['status'] ?? '');
  }

  bool get isSuccess => status.toLowerCase() == 'ok';
}
