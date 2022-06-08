class AuthenticationData {
  String accessToken;
  String refreshToken;
  int expiresIn;


  AuthenticationData({required this.accessToken, required this.refreshToken, required this.expiresIn,});

  factory AuthenticationData.fromJson(Map<String, dynamic> json) {
    return AuthenticationData(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresIn: int.parse(json['expires_in']),
    );
  }



}