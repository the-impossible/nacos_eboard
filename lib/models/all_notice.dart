import 'dart:convert';

class AllNotice {
  String id;
  String title;
  String description;
  String dateCreated;

  AllNotice({
    required this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
  });

  factory AllNotice.fromJson(Map<String, dynamic> json) => AllNotice(
        id: json["id"].toString(),
        title: json["title"],
        description: json["description"],
        dateCreated: json["date_created"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_created": dateCreated,
      };
}

List<AllNotice> allNoticeFromJson(String str) => List<AllNotice>.from(json.decode(str).map((x) => AllNotice.fromJson(x)));

String allNoticeToJson(List<AllNotice> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));