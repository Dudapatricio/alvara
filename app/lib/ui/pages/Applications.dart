import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/repositories/DomainApplicationRepository.dart';
import 'package:flutter/material.dart';
import 'package:app/domain/models/Application.dart';
import 'package:app/domain/repositories/IRepository.dart';

class Applications extends StatefulWidget {
  const Applications({super.key});

  @override
  State<Applications> createState() => _CompaniesState();
}

class _CompaniesState extends State<Applications> {
  late final IRepository<Application> repository;
  late Future<List<Application>> companiesFuture;

  @override
  void initState() {
    super.initState();
    repository =
        DomainRepositoryFactory().getRepository<DomainApplicationRepository>();
    companiesFuture = repository.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Empresas")),
      body: FutureBuilder<List<Application>>(
        future: companiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }
          final applications = snapshot.data ?? [];
          if (applications.isEmpty) {
            return const Center(child: Text("Nenhuma empresa encontrada."));
          }
          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];
              return ListTile(
                title: Text(application.title ?? "Sem nome"),
                subtitle: Text(application.id?.toString() ?? "ID desconhecido"),
              );
            },
          );
        },
      ),
    );
  }
}
