import 'dart:convert';
import 'package:app/data/Api.dart';
import 'package:app/data/models/Company.dart';
import 'package:app/data/repositories/IApiRepository.dart';

class ApiCompaniesRepository implements IApiRepository<Company> {
  @override
  Api apiDomain = Api.getInstance();

  @override
  Future<List<Company>> list() async {
    final response = await apiDomain.get("/companies");
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Company.fromMap(jsonItem)).toList();
    } else {
      throw Exception('Erro na requisição: ${response.statusCode}');
    }
  }

  @override
  Future<Company> create(Company company) async {
    final response = await apiDomain.post("/companies", company.toJson());

    if (response.statusCode == 201) {
      final jsonMap = json.decode(response.body);
      return Company.fromMap(jsonMap);
    } else {
      throw Exception('Falha ao criar empresa: ${response.statusCode}');
    }
  }

  @override
  Future<Company> get() {
    throw UnimplementedError();
  }
}
