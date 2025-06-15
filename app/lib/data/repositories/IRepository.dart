abstract class IRepository<T> {
  Future<T> get();
  Future<List<T>> list();
  Future<T> create(T object);
}
