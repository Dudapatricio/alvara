import 'package:flutter/material.dart';
import 'nova_solic.dart';
import 'lista_solic.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página Inicial')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bem-vinda ao sistema de alvará!',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/nova_solic');
              },
              child: const Text('Nova Solicitação de Alvará'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/lista_solic');
              },
              child: const Text('Minhas Solicitações'),
            ),
          ],
        ),
      ),
    );
  }
}
