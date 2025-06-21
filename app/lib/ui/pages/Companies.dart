import 'package:flutter/material.dart';
import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:app/domain/models/Company.dart';
import 'package:app/ui/components/AddCompany.dart';
import 'package:app/ui/components/NewApplication.dart';

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  State<Companies> createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  late final DomainCompanyRepository repository;
  late Future<List<Company>> companiesFuture;

  @override
  void initState() {
    super.initState();
    repository = DomainRepositoryFactory().getRepository<DomainCompanyRepository>();
    _loadCompanies();
  }

  void _loadCompanies() {
    companiesFuture = repository.list();
  }

  Future<void> _confirmAndDelete(Company company) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirmar exclusão"),
        content: const Text("Deseja realmente excluir esta empresa?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Excluir"),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await repository.delete(company.id!);
      setState(_loadCompanies);
    }
  }

  void _showAddForm() async {
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 16,
        ),
        child: const AddCompany(),
      ),
    );

    if (created == true) {
      setState(_loadCompanies);
    }
  }

  void _showNewApplicationForm(int companyId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16, right: 16, top: 16,
        ),
        child: NewApplication(id: companyId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Empresas")),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddForm,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Company>>(
        future: companiesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erro: ${snapshot.error}"));
          }

          final companies = snapshot.data ?? [];

          if (companies.isEmpty) {
            return const Center(child: Text("Nenhuma empresa encontrada."));
          }

          return ListView.separated(
            itemCount: companies.length,
            padding: const EdgeInsets.all(12),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final company = companies[index];

              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  title: Text(company.name ?? "Sem nome",
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text("ID: ${company.id ?? 'Desconhecido'}"),
                  trailing: Wrap(
                    spacing: 8,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.send, color: Colors.blue),
                        tooltip: "Nova solicitação",
                        onPressed: () => _showNewApplicationForm(company.id ?? 0),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: "Excluir empresa",
                        onPressed: () => _confirmAndDelete(company),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
