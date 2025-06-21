import 'package:flutter/material.dart';
import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/repositories/DomainApplicationRepository.dart';
import 'package:app/domain/models/Application.dart';

class Applications extends StatefulWidget {
  const Applications({super.key});

  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  late final DomainApplicationRepository _repository;
  late Future<List<Application>> _applicationsFuture;
  final Map<String, String> statusMap = {
    'OPN': 'Criado',
    'SED': 'Enviado',
    'SUS': 'Aprovado',
    "RGC": "Rejeitado",
  };

  @override
  void initState() {
    super.initState();
    _repository =
        DomainRepositoryFactory().getRepository<DomainApplicationRepository>();
    _loadApplications();
  }

  void _loadApplications() {
    _applicationsFuture = _repository.list();
  }

  Future<void> _deleteApplication(Application app) async {
    await _repository.delete(app.id!);
    setState(_loadApplications);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'SUS':
        return Colors.green;
      case 'RGC':
        return Colors.red;
      case "OPN":
        return Colors.black;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Solicitações")),
      body: FutureBuilder<List<Application>>(
        future: _applicationsFuture,
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
              final app = applications[index];
              return ListTile(
                title: Text(app.title ?? "Sem nome"),
                subtitle: Row(
                  children: [
                    Text("ID: ${app.id ?? 'Desconhecido'} - "),
                    Text(
                      statusMap[app.status] ?? app.status!,
                      style: TextStyle(color: _getStatusColor(app.status!)),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _deleteApplication(app),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
