import 'dart:convert';

class Token {
  Token({
    required this.refresh,
    required this.access,
  });

  String refresh;
  String access;

  factory Token.fromJson(Map<String, dynamic> json) =>
      Token(
        refresh: json["refresh"],
        access: json["access"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
      };
}

Token tokenFromJson(String str) =>
    Token.fromJson(json.decode(str));

String tokenToJson(Token data) =>
    json.encode(data.toJson());
