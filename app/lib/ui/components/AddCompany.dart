import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/models/Company.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:app/ui/pages/Utils.dart';
import 'package:flutter/material.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompany();
}

class _AddCompany extends State<AddCompany> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _cnpj = "";
  String _addressString = "";
  String _description = "";

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("Nome inválido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(3)
                            .isMaxLengh(200)
                            .apply(),
                onSaved: (value) => _name = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "CNPJ"),
                maxLength: 14,
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("CNPJ inválido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(14)
                            .isMaxLengh(14)
                            .isOnlyNumber()
                            .apply(),
                onSaved: (value) => _cnpj = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Endereço"),
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("Endereço inválido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(3)
                            .isMaxLengh(200)
                            .apply(),
                onSaved: (value) => _addressString = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                onSaved: (value) => _description = value ?? '',
              ),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: _submit, child: const Text("Salvar")),
            ],
          ),
        ),
      ],
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    final repository =
        DomainRepositoryFactory().getRepository<DomainCompanyRepository>();
    repository
        .create(
          Company(
            name: _name,
            cnpj: _cnpj,
            addressString: _addressString,
            description: _description,
          ),
        )
        .then((_) {
          if (!mounted) return;
          Navigator.pop(context, true);
          showDialog(
            context: context,
            builder:
                (_) => const AlertDialog(
                  content: Text('Empresa criada com sucesso!'),
                ),
          );
        })
        .onError((error, _) {
          if (!mounted) return;
          showDialog(
            context: context,
            builder:
                (_) => AlertDialog(
                  title: const Text('Erro'),
                  content: Text('Falha ao criar empresa: $error'),
                ),
          );
        });
  }
}
