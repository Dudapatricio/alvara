import 'package:flutter/material.dart';
import '../models/detalhes_arguments.dart';

class DetalhesSolicitacaoPage extends StatelessWidget {
  final DetalhesArguments args;

  const DetalhesSolicitacaoPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Título: ${args.titulo}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            Text('Status: ${args.status}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text('Data: ${args.data ?? "Não informada"}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}

