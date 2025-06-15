import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:flutter/material.dart';
import 'package:app/domain/models/Company.dart';
import 'package:app/domain/repositories/IRepository.dart';

class Applications extends StatefulWidget {
  const Applications({super.key});

  @override
  State<Applications> createState() => _CompaniesState();
}

class _CompaniesState extends State<Applications> {
  late final IRepository<Company> repository;
  late Future<List<Company>> companiesFuture;

  @override
  void initState() {
    super.initState();
    repository =
        DomainRepositoryFactory().getRepository<DomainCompanyRepository>();
    companiesFuture = repository.list();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Empresas")),
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
              );
            },
          );
        },
      ),
    );
  }
}
