import 'package:app/domain/models/IModel.dart';
import 'package:app/data/models/Application.dart' as api;

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

  factory Application.fromApi(api.Application object) {
    return Application(
      status: object.status,
      title: object.title,
      type: object.type,
      companyId: object.companyId,
    );
  }
  @override
  api.Application toApi() {
    return api.Application(
      status: status,
      title: title,
      type: type,
      companyId: companyId,
    );
  }
}
