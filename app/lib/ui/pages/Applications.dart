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
    'RGC': 'Rejeitado',
  };
  final Map<String, String> typeMap = {
    "CMT": "COMMERCIAL",
    "IND": "INDUSTRIAL",
    "RST": "RESIDENTIAL",
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
      case 'OPN':
        return Colors.orange;
      case 'SED':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Future<void> _handleAction(
    Future<void> Function() action,
    String errorMsg,
  ) async {
    try {
      await action();
      setState(_loadApplications);
    } catch (e) {
      _showError("$errorMsg: $e");
    }
  }

  Widget _buildApplicationCard(Application app) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              app.title ?? 'Sem nome',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text("ID: ${app.id ?? 'Desconhecido'}"),
            const SizedBox(height: 4),
            Text(
              "Status: ${statusMap[app.status] ?? app.status}",
              style: TextStyle(
                color: _getStatusColor(app.status ?? ''),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text("Tipo: ${typeMap[app.type] ?? app.type}"),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildIconButton(
                  icon: Icons.check,
                  color: Colors.green,
                  tooltip: 'Aprovar',
                  onPressed:
                      () => _handleAction(
                        () => _repository.accept(app.id!),
                        'Erro ao aprovar',
                      ),
                ),
                _buildIconButton(
                  icon: Icons.close,
                  color: Colors.red,
                  tooltip: 'Rejeitar',
                  onPressed:
                      () => _handleAction(
                        () => _repository.reject(app.id!),
                        'Erro ao rejeitar',
                      ),
                ),
                _buildIconButton(
                  icon: Icons.send,
                  color: Colors.blue,
                  tooltip: 'Enviar',
                  onPressed:
                      () => _handleAction(
                        () => _repository.send(app.id!),
                        'Erro ao enviar',
                      ),
                ),
                _buildIconButton(
                  icon: Icons.delete,
                  color: Colors.grey.shade700,
                  tooltip: 'Excluir',
                  onPressed:
                      () => _handleAction(
                        () => _repository.delete(app.id!),
                        'Erro ao excluir',
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required Color color,
    required String tooltip,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: IconButton(
        icon: Icon(icon, color: color),
        tooltip: tooltip,
        onPressed: onPressed,
      ),
    );
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
              return _buildApplicationCard(applications[index]);
            },
          );
        },
      ),
    );
  }
}
