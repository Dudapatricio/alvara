import 'package:app/data/repositories/IRepository.dart';
import 'package:app/data/repositories/ApiCompaniesRepository.dart';

class ApiRepositoryfacotory {
  final _creators = <Type, dynamic Function()>{
    ApiCompaniesRepository: () => ApiCompaniesRepository(),
  };

  T getRepository<T extends IRepository>() {
    final creator = _creators[T];
    if (creator != null) {
      return creator() as T;
    } else {
      throw Exception('Repositório não registrado para tipo $T');
    }
  }
}
