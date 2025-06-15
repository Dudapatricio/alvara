import 'dart:convert';

import 'package:app/data/models/IModel.dart';

class Application implements IModel {
  @override
  int? id;
  String status;
  String title;
  String type;
  String companyId;

  Application({
    this.id,
    required this.status,
    required this.title,
    required this.type,
    required this.companyId,
  });
  factory Application.fromMap(Map<String, dynamic> object) {
    return Application(
      status: object["status"],
      title: object["title"],
      type: object["type"],
      companyId: object["company_id"],
    );
  }

  factory Application.fromJson(String jsonContent) {
    final object = json.decode(jsonContent);
    return Application(
      status: object["status"],
      title: object["title"],
      type: object["type"],
      companyId: object["company_id"],
    );
  }

  String toJson() {
    final jsonMap = {
      "status": status,
      "title": title,
      "type": type,
      "company_id": companyId,
    };
    return json.encode(jsonMap);
  }
}
