import 'package:app/domain/repositories/DomainApplicationRepository.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:app/domain/repositories/IRepository.dart';

class DomainRepositoryFactory {
  final _creators = <Type, dynamic Function()>{
    DomainCompanyRepository: () => DomainCompanyRepository(),
    DomainApplicationRepository: () => DomainApplicationRepository(),
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
