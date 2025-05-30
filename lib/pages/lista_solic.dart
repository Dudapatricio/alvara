import 'package:flutter/material.dart';
import '../models/detalhes_arguments.dart';  // Importa a classe correta

class ListaSolicitacoesPage extends StatelessWidget {
  final List<Map<String, String?>> solicitacoes = [
    {
      'titulo': 'Alvará para evento',
      'status': 'Aguardando aprovação',
      'data': null,
    },
    {
      'titulo': 'Alvará comercial',
      'status': 'Aprovado',
      'data': '15/05/2025',
    },
    {
      'titulo': 'Alvará de construção',
      'status': 'Negado',
      'data': '10/05/2025',
    },
  ];

  Color _statusColor(String status) {
    switch (status) {
      case 'Aprovado':
        return Colors.green;
      case 'Negado':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Minhas Solicitações')),
      body: ListView.builder(
        itemCount: solicitacoes.length,
        itemBuilder: (context, index) {
          final solicitacao = solicitacoes[index];
          final data = solicitacao['data'];

          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(solicitacao['titulo']!),
              subtitle: Text(data != null ? 'Data: $data' : 'Data: Não informada'),
              trailing: Text(
                solicitacao['status']!,
                style: TextStyle(
                  color: _statusColor(solicitacao['status']!),
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  '/detalhes',
                  arguments: DetalhesArguments(
                    titulo: solicitacao['titulo']!,
                    status: solicitacao['status']!,
                    data: data,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}


