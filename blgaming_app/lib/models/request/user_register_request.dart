class UserRegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final String phone;

  UserRegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
    'fullName': fullName,
    'email': email,
    'password': password,
    'phone': phone,
  };

  factory UserRegisterRequest.fromJson(Map<String, dynamic> json) {
    return UserRegisterRequest(
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
    );
  }
}
