import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/nova_solic.dart';
import 'pages/lista_solic.dart';
import 'pages/detalhes_solic.dart';
import 'models/detalhes_arguments.dart';

void main() {
  runApp(const AlvaraApp());
}

class AlvaraApp extends StatelessWidget {
  const AlvaraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Alvará',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade900,
          secondary: Colors.orangeAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue.shade900,
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade900,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => LoginPage(),  // sem const
        '/home': (context) => HomePage(),    // sem const
        '/nova_solic': (context) => NovaSolicitacao(), // sem const
        '/lista_solic': (context) => ListaSolicitacoesPage(), // sem const
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/detalhes') {
          final args = settings.arguments as DetalhesArguments;
          return MaterialPageRoute(
            builder: (context) {
              return DetalhesSolicitacaoPage(args: args);
            },
          );
        }
        return null;
      },
    );
  }
}
