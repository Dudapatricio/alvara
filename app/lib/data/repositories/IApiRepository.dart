import 'package:app/data/models/IModel.dart';

abstract class IApiRepository<T extends IModel> {
  Future<T> get();
  Future<List<T>> list();
  Future<T> create(T object);
}
