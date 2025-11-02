class UserResetPasswordRequest {
  final String email;
  final String newPassword;
  final String repeatPassword;
  final int otp;

  UserResetPasswordRequest({
    required this.email,
    required this.newPassword,
    required this.repeatPassword,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "otp": otp,
      "email": email,
      "newPassword": newPassword,
      "repeatPassword": repeatPassword,
    };
  }
}
