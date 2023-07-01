import 'dart:convert';
import 'dart:typed_data';

import 'package:intl/intl.dart';

class NoticeDetail {
  // final String formatted = formatter.format(now);

  String id;
  String title;
  String description;
  String dateCreated;
  String createdBy;
  dynamic file;
  dynamic img;
  dynamic docs;

  NoticeDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.createdBy,
    this.file,
    this.img,
    this.docs,
  });

  factory NoticeDetail.fromJson(Map<String, dynamic> json) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted =
        formatter.format(DateTime.parse(json["date_created"]));

    return NoticeDetail(
      id: json["id"].toString(),
      title: json["title"],
      description: json["description"],
      dateCreated: formatted,
      createdBy: json["created_by"],
      file: json["file"],
      img: (json["img"] == null) ? null : base64Decode(json["img"]),
      docs: (json["docs"] == null) ? null : base64Decode(json["docs"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_created": dateCreated,
        "file": file,
        "img": (img == null) ? null : base64Encode(img!),
        "docs": (docs == null) ? null : base64Encode(docs!),
      };
}

NoticeDetail noticeDetailFromJson(String str) =>
    NoticeDetail.fromJson(json.decode(str));

String noticeDetailToJson(NoticeDetail data) => json.encode(data.toJson());
