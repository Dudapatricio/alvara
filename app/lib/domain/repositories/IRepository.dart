import 'package:app/domain/models/IModel.dart';

abstract class IRepository<T extends IModel> {
  Future<T> get();
  Future<List<T>> list();
  Future<T> create(T object);
  Future delete(int id);
}
