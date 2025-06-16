import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/repositories/DomainApplicationRepository.dart';
import 'package:flutter/material.dart';
import 'package:app/domain/models/Application.dart';
import 'package:app/domain/repositories/IRepository.dart';

class Applications extends StatefulWidget {
  const Applications({super.key});

  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  late final DomainApplicationRepository repository;
  late Future<List<Application>> applicationsFuture;

  @override
  void initState() {
    super.initState();
    repository =
        DomainRepositoryFactory().getRepository<DomainApplicationRepository>();
    _loadApplications();
  }

  void _loadApplications() {
    applicationsFuture = repository.list();
  }

  void _deleteApplication(Application app) async {
    await repository.delete(app.id!);
    setState(() => _loadApplications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Solicitações")),
      body: FutureBuilder<List<Application>>(
        future: applicationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }
          final applications = snapshot.data ?? [];
          if (applications.isEmpty) {
            return const Center(child: Text("Nenhuma solicitação encontrada."));
          }
          return ListView.builder(
            itemCount: applications.length,
            itemBuilder: (context, index) {
              final application = applications[index];
              return ListTile(
                title: Text(application.title ?? "Sem nome"),
                subtitle: Text(application.id?.toString() ?? "ID desconhecido"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteApplication(application),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
