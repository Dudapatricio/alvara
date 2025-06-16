import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:app/ui/components/AddCompany.dart';
import 'package:app/ui/components/NewApplication.dart';
import 'package:flutter/material.dart';
import 'package:app/domain/models/Company.dart';

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
    repository =
        DomainRepositoryFactory().getRepository<DomainCompanyRepository>();
    companiesFuture = repository.list();
  }

  void _loadCompanies() {
    companiesFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Empresas")),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _ShowAddForm(context),
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
          return ListView.builder(
            itemCount: companies.length,
            itemBuilder: (context, index) {
              final company = companies[index];
              return ListTile(
                title: Text(company.name ?? "Sem nome"),
                subtitle: Text(company.id?.toString() ?? "ID desconhecido"),
                onTap: () => _showNewApplicationForm(context, company.id ?? 0),
              );
            },
          );
        },
      ),
    );
  }

  void _ShowAddForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: const AddCompany(),
          ),
    );
  }

  void _showNewApplicationForm(BuildContext context, int id) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder:
          (context) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16,
              right: 16,
              top: 16,
            ),
            child: NewApplication(id: id),
          ),
    );
  }
}
