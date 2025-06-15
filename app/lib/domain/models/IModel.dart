import 'package:app/data/models/IModel.dart' as api;

abstract class IModel {
  int? id;
  api.IModel toApi();
  IModel.fromApi(api.IModel model);
}
