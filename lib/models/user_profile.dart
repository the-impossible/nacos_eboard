import 'dart:convert';

class UserProfile {
  String userId;
  String username;
  String name;
  bool isLec;

  UserProfile({
    required this.userId,
    required this.username,
    required this.name,
    required this.isLec,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
        userId: json["user_id"],
        username: json["username"],
        name: json["name"],
        isLec: json["is_lec"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "username": username,
        "name": name,
        "is_lec": isLec,
      };
}

UserProfile userProfileFromJson(String str) =>
    UserProfile.fromJson(json.decode(str));

String userProfileToJson(UserProfile data) => json.encode(data.toJson());
