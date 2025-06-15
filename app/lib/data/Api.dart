import 'package:http/http.dart' as http;

class Api {
  final String baseDomain;
  static Api? _instance;

  // Construtor privado
  Api._({this.baseDomain = "http://localhost:8000"});

  // Singleton getter
  static Api getInstance() {
    _instance ??= Api._();
    return _instance!;
  }

  Future<http.Response> request(String uri) async {
    final url = Uri.parse('$baseDomain$uri');
    final response = await http.get(url);
    return response;
  }
}
