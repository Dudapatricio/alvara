import 'package:app/data/factories/ApiRepositoryfacotory.dart';
import 'package:app/data/models/IModel.dart';
import 'package:app/data/repositories/ApiCompaniesRepository.dart';
import 'package:app/data/repositories/IApiRepository.dart';
import 'package:app/domain/models/Company.dart';
import 'package:app/domain/repositories/IRepository.dart';

class DomainCompanyRepository implements IRepository<Company> {
  @override
  IApiRepository<IModel> repository;
  DomainCompanyRepository()
    : repository =
          ApiRepositoryFactory().getRepository<ApiCompaniesRepository>();
  @override
  Future<Company> create(Company object) async {
    final apiModel = await repository.create(object.toApi());
    return Company.fromApi(apiModel as dynamic);
  }

  @override
  Future<Company> get() {
    throw UnimplementedError();
  }

  @override
  Future<List<Company>> list() async {
    final apiList = await repository.list();
    return apiList
        .map((apiModel) => Company.fromApi(apiModel as dynamic))
        .toList();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }
}
