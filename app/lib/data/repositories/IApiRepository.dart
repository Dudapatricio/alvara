import 'package:app/data/Api.dart';
import 'package:app/data/models/IModel.dart';

abstract class IApiRepository<T extends IModel> {
  late Api apiDomain;
  Future<T> get();
  Future<List<T>> list();
  Future<T> create(T object);
}
