import 'package:http/http.dart' as http;

class Api {
  final String baseDomain;
  static Api? _instance;

  // Construtor privado
  Api._({this.baseDomain = "http://localhost:8000/api"});

  // Singleton getter
  static Api getInstance() {
    _instance ??= Api._();
    return _instance!;
  }

  Future<http.Response> get(String uri) async {
    final url = Uri.parse('$baseDomain$uri');
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return response;
  }

  Future<http.Response> post(String uri, String obj) async {
    final url = Uri.parse('$baseDomain$uri');
    final response = await http.post(
      url,
      body: obj,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return response;
  }

  Future<http.Response> delete(String uri, int id) async {
    final url = Uri.parse("$baseDomain$uri/$id");
    final response = await http.delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
    );
    return response;
  }
}
