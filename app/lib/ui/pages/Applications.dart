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
    try {
      await _repository.delete(app.id!);
      setState(_loadApplications);
    } catch (e) {
      _showError("Erro ao excluir: $e");
    }
  }

  Future<void> _acceptApplication(Application app) async {
    try {
      await _repository.accept(app.id!);
      setState(_loadApplications);
    } catch (e) {
      _showError("Erro ao aceitar: $e");
    }
  }

  Future<void> _rejectApplication(Application app) async {
    try {
      await _repository.reject(app.id!);
      setState(_loadApplications);
    } catch (e) {
      _showError("Erro ao rejeitar: $e");
    }
  }

  Future<void> _sendApplication(Application app) async {
    try {
      await _repository.send(app.id!);
      setState(_loadApplications);
    } catch (e) {
      _showError("Erro ao enviar: $e");
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      tooltip: 'Aprovar',
                      onPressed: () => _acceptApplication(app),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      tooltip: 'Rejeitar',
                      onPressed: () => _rejectApplication(app),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      tooltip: 'Enviar',
                      onPressed: () => _sendApplication(app),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.grey),
                      tooltip: 'Excluir',
                      onPressed: () => _deleteApplication(app),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
