import 'dart:convert';

import 'package:app/data/models/IModel.dart';

class Company implements IModel {
  @override
  int? id;
  String name;
  String cnpj;
  String addressString;
  String description;

  Company({
    this.id,
    required this.name,
    required this.cnpj,
    required this.addressString,
    required this.description,
  });

  factory Company.fromMap(Map<String, dynamic> object) {
    return Company(
      id: object["id"],
      name: object["name"],
      cnpj: object["cnpj"],
      addressString: object["address_string"],
      description: object["description"],
    );
  }

  factory Company.fromJson(String jsonContent) {
    final object = json.decode(jsonContent);
    return Company(
      id: object["id"],
      name: object["name"],
      cnpj: object["cnpj"],
      addressString: object["address_string"],
      description: object["description"],
    );
  }

  String toJson() {
    final jsonMap = {
      'name': name,
      'cnpj': cnpj,
      'address_string': addressString,
      'description': description,
    };
    return json.encode(jsonMap);
  }
}
