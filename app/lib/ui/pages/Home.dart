import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tela Pricipal")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/companies");
                },
                child: const Text("Empresas"),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: FilledButton(
                onPressed: () {},
                child: const Text("Solicitações"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
