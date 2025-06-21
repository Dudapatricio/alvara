import 'dart:convert';

import 'package:app/data/Api.dart';
import 'package:app/data/models/Application.dart';
import 'package:app/data/repositories/IApiRepository.dart';

class ApiApplicationRepository implements IApiRepository<Application> {
  @override
  Api apiDomain = Api.getInstance();

  @override
  Future<Application> create(Application object) async {
    final response = await apiDomain.post("/applications", object.toJson());
    if (response.statusCode != 201) {
      throw Exception("Falha ao criar empresa: $object");
    }
    final data = json.decode(response.body);
    return Application.fromMap(data);
  }

  @override
  Future<Application> get() {
    throw UnimplementedError();
  }

  @override
  Future<List<Application>> list() async {
    final response = await apiDomain.get("/applications");
    if (response.statusCode != 200) {
      throw Exception("Erro ao obter lista de applications");
    }
    final List<dynamic> data = json.decode(response.body);

    return data.map((jsonItem) => Application.fromMap(jsonItem)).toList();
  }

  @override
  Future delete(int id) {
    throw UnimplementedError();
  }
}
