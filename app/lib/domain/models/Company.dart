import 'package:app/domain/models/IModel.dart';
import 'package:app/data/models/Company.dart' as api;

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

  @override
  factory Company.fromApi(api.Company model) {
    return Company(
      id: model.id,
      name: model.name,
      cnpj: model.cnpj,
      addressString: model.addressString,
      description: model.description,
    );
  }

  @override
  api.Company toApi() {
    return api.Company(
      id: id,
      name: name,
      cnpj: cnpj,
      addressString: addressString,
      description: description,
    );
  }
}
