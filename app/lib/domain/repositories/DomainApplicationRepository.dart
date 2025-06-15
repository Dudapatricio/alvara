import 'package:app/data/factories/ApiRepositoryfacotory.dart';
import 'package:app/data/models/IModel.dart';
import 'package:app/data/repositories/ApiApplicationRepository.dart';
import 'package:app/data/repositories/IApiRepository.dart';
import 'package:app/domain/models/Application.dart';
import 'package:app/domain/repositories/IRepository.dart';

class DomainApplicationRepository implements IRepository<Application> {
  @override
  IApiRepository<IModel> repository;
  DomainApplicationRepository()
    : repository =
          ApiRepositoryFactory().getRepository<ApiApplicationRepository>();
  @override
  Future<Application> create(Application object) async {
    final apiModel = await repository.create(object.toApi());
    return Application.fromApi(apiModel as dynamic);
  }

  @override
  Future<Application> get() {
    throw UnimplementedError();
  }

  @override
  Future<List<Application>> list() async {
    final apiList = await repository.list();
    return apiList
        .map((apiModel) => Application.fromApi(apiModel as dynamic))
        .toList();
  }
}
