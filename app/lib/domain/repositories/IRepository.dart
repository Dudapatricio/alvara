import 'package:app/domain/models/IModel.dart';
import 'package:app/data/repositories/IApiRepository.dart';

abstract class IRepository<T extends IModel> {
  late IApiRepository repository;
  Future<T> get();
  Future<List<T>> list();
  Future<T> create(T object);
}
