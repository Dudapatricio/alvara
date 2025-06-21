import 'package:flutter/material.dart';
import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/models/Application.dart';
import 'package:app/domain/repositories/DomainApplicationRepository.dart';
import 'package:app/ui/pages/Utils.dart';

class NewApplication extends StatefulWidget {
  final int companyId;
  const NewApplication({super.key, required this.companyId});

  @override
  State<NewApplication> createState() => _NewApplicationState();
}

class _NewApplicationState extends State<NewApplication> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String? _type;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        left: 24,
        right: 24,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Título",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[50],
              ),
              validator: (value) => Validators(value)
                  .setErroMessage("Título inválido")
                  .isNotNull()
                  .isNotEmpty()
                  .isMinLengh(3)
                  .isMaxLengh(200)
                  .apply(),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: "Tipo",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: theme.inputDecorationTheme.fillColor ?? Colors.grey[50],
              ),
              items: const [
                DropdownMenuItem(value: "CMT", child: Text("COMMERCIAL")),
                DropdownMenuItem(value: "IND", child: Text("INDUSTRIAL")),
                DropdownMenuItem(value: "RST", child: Text("RESIDENTIAL")),
              ],
              value: _type,
              onChanged: (value) => setState(() => _type = value),
              validator: (value) => Validators(value)
                  .setErroMessage("Tipo inválido")
                  .isNotNull()
                  .apply(),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.check),
              label: const Text("Salvar"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final repository =
        DomainRepositoryFactory().getRepository<DomainApplicationRepository>();

    repository
        .create(Application(
          companyId: widget.companyId,
          title: _titleController.text,
          type: _type!,
        ))
        .then((_) {
          if (!mounted) return;
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (_) => const AlertDialog(
              content: Text('Solicitação criada com sucesso!'),
            ),
          );
        })
        .onError((error, _) {
          if (!mounted) return;
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Erro'),
              content: Text('Falha ao criar solicitação: $error'),
            ),
          );
        });
  }
}
