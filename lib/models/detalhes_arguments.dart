class DetalhesArguments {
  final String titulo;
  final String status;
  final String? data;

  DetalhesArguments({
    required this.titulo,
    required this.status,
    this.data,
  });
  @override
  String toString() =>
    'DetalhesArguments(titulo: $titulo, status: $status, data: $data)';
}
