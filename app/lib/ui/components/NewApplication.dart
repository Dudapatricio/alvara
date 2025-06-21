import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/models/Application.dart';
import 'package:app/domain/repositories/DomainApplicationRepository.dart';
import 'package:app/ui/pages/Utils.dart';
import 'package:flutter/material.dart';

class NewApplication extends StatefulWidget {
  late int id;
  NewApplication({super.key, required this.id});

  @override
  State<NewApplication> createState() => _NewApplication(id: id);
}

class _NewApplication extends State<NewApplication> {
  final _formKey = GlobalKey<FormState>();
  String? _title;
  String? _type;
  late int id;
  _NewApplication({required this.id});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Titulo"),
                validator:
                    (value) =>
                        Validators(value)
                            .setErroMessage("Titulo inválido")
                            .isNotNull()
                            .isNotEmpty()
                            .isMinLengh(3)
                            .isMaxLengh(200)
                            .apply(),
                onSaved: (value) => _title = value ?? '',
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(labelText: "Tipo"),
                items: [
                  DropdownMenuItem(value: "CMT", child: Text("COMMERCIAL")),
                  DropdownMenuItem(value: "IND", child: Text("INDUSTRIAL")),
                  DropdownMenuItem(value: "RST", child: Text("RESIDENTIAL")),
                ],

                onChanged: (value) => {setState(() => _type = value ?? "")},
                validator:
                    (value) =>
                        Validators(
                          value,
                        ).setErroMessage("Tipo inválido").isNotNull().apply(),
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
        DomainRepositoryFactory().getRepository<DomainApplicationRepository>();
    repository
        .create(Application(companyId: id, title: _title!, type: _type!))
        .then((_) {
          if (!mounted) return;
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder:
                (_) => const AlertDialog(
                  content: Text('Solicitação criada com sucesso!'),
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
                  content: Text('Falha ao criar solicitação: $error'),
                ),
          );
        });
  }
}
