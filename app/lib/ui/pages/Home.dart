import 'package:flutter/material.dart';
import 'package:app/ui/components/MyTextButton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tela Principal")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 1.2,
          ),
          children: [
            _buildMenuButton(
              context,
              label: "Empresas",
              route: "/companies",
            ),
            _buildMenuButton(
              context,
              label: "Solicitações",
              route: "/applications",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String label,
    required String route,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: MyTextButton(
        onPressed: () => Navigator.pushNamed(context, route),
        text: label,
        // Garanta que o botão ocupe todo o espaço
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
