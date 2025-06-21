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
  Future<void> delete(int id) async {
    final response = await apiDomain.delete("/applications", id);
    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        throw Exception(data["message"] ?? "Erro desconhecido ao deletar");
      }
      throw Exception("Falha ao deletar application com id $id");
    }
  }

  Future<void> accept(int id) async {
    final response = await apiDomain.post("/applications/$id/accept", null);
    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        throw Exception(data["message"] ?? "Erro ao aceitar");
      }
      throw Exception("Falha ao aceitar application com id $id");
    }
  }

  Future<void> reject(int id) async {
    final response = await apiDomain.post("/applications/$id/reject", null);
    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        throw Exception(data["message"] ?? "Erro ao rejeitar");
      }
      throw Exception("Falha ao rejeitar application com id $id");
    }
  }

  Future<void> send(int id) async {
    final response = await apiDomain.post("/applications/$id/send", null);
    if (response.statusCode != 200) {
      if (response.statusCode == 400) {
        final data = json.decode(response.body);
        throw Exception(data["message"] ?? "Erro ao enviar");
      }
      throw Exception("Falha ao enviar application com id $id");
    }
  }
}
