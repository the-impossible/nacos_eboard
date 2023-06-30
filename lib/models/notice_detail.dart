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
  String file;
  Uint8List img;
  Uint8List docs;

  NoticeDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.dateCreated,
    required this.createdBy,
    required this.file,
    required this.img,
    required this.docs,
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
      img: base64Decode(json["img"]),
      docs: base64Decode(json["docs"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date_created": dateCreated,
        "file": file,
        "img": base64Encode(img),
        "docs": base64Encode(docs),
      };
}

NoticeDetail noticeDetailFromJson(String str) =>
    NoticeDetail.fromJson(json.decode(str));

String noticeDetailToJson(NoticeDetail data) => json.encode(data.toJson());
