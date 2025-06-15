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
    required this.name,
    required this.cnpj,
    required this.addressString,
    required this.description,
  });

  factory Company.fromJson(String jsonContent) {
    final object = json.decode(jsonContent);
    return Company(
      name: object["name"],
      cnpj: object["cnpj"],
      addressString: object["addressString"],
      description: object["description"],
    );
  }

  String toJson() {
    final jsonMap = {
      'name': name,
      'cnpj': cnpj,
      'addressString': addressString,
      'description': description,
    };
    return json.encode(jsonMap);
  }
}
