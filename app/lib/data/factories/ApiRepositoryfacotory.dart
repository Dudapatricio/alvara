import 'package:app/data/repositories/IApiRepository.dart';
import 'package:app/data/repositories/ApiCompaniesRepository.dart';

class ApiRepositoryFactory {
  final _creators = <Type, dynamic Function()>{
    ApiCompaniesRepository: () => ApiCompaniesRepository(),
  };

  T getRepository<T extends IApiRepository>() {
    final creator = _creators[T];
    if (creator != null) {
      return creator() as T;
    } else {
      throw Exception('Repositório não registrado para tipo $T');
    }
  }
}
