import 'package:app/ui/components/MyTextButton.dart';
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
              child: MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/companies");
                },
                text: "Empresas",
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: MyTextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/applications");
                },
                text: "Solicitações",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
