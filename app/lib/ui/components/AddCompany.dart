import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/models/Company.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:app/ui/pages/Utils.dart';
import 'package:flutter/material.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<StatefulWidget> createState() => _AddCompany();
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
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Nome"),
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("Nome invalido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(10)
                            .isMaxLengh(200)
                            .apply(),
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Cnpj"),
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("Cnpj invalido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(14)
                            .isMaxLengh(14)
                            .isOnlyNumber()
                            .apply(),
                onSaved: (value) => _cnpj = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Endereço"),
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("Endereço invalido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(3)
                            .isMaxLengh(200)
                            .apply(),
                onSaved: (value) => _addressString = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Descrição"),
                onSaved: (value) => _description = value!,
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    Navigator.of(context).pop();
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
        .then((company) {
          if (!context.mounted) return;
          showDialog(
            context: context,
            builder:
                (_) => const AlertDialog(
                  content: Text('Empresa criada com sucesso!'),
                ),
          );
        })
        .onError((error, _) {
          if (!context.mounted) return;
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
