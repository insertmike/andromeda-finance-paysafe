import 'dart:convert';

abstract class AuthToken {
  AuthToken();
  factory AuthToken.basic(String username, String password) =>
      BasicAuthToken(username, password);
}

class BasicAuthToken extends AuthToken {
  final String username;
  final String password;

  BasicAuthToken(this.username, this.password);

  @override
  String toString() {
    return "Basic " + base64Encode(utf8.encode('$username:$password'));
  }
}
