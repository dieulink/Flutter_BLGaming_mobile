class GgLoginRequest {
  final String idToken;

  GgLoginRequest({required this.idToken});

  Map<String, dynamic> toJson() {
    return {
      'idToken': idToken,
    };
  }
}
