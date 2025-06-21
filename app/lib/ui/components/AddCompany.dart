import 'package:flutter/material.dart';
import 'package:app/domain/factories/DomainRepositoryFactory.dart';
import 'package:app/domain/models/Company.dart';
import 'package:app/domain/repositories/DomainCompanyRepository.dart';
import 'package:app/ui/pages/Utils.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<AddCompany> createState() => _AddCompany();
}

class _AddCompany extends State<AddCompany> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _cnpjController.dispose();
    _addressController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            _buildField(
              controller: _nameController,
              label: "Nome",
              validator: (value) => Validators(value)
                  .setErroMessage("Nome inválido")
                  .isNotNull()
                  .isNotEmpty()
                  .isMinLengh(3)
                  .isMaxLengh(200)
                  .apply(),
            ),
            _buildField(
              controller: _cnpjController,
              label: "CNPJ",
              maxLength: 14,
              keyboardType: TextInputType.number,
              validator: (value) => Validators(value)
                  .setErroMessage("CNPJ inválido")
                  .isNotNull()
                  .isNotEmpty()
                  .isMinLengh(14)
                  .isMaxLengh(14)
                  .isOnlyNumber()
                  .apply(),
            ),
            _buildField(
              controller: _addressController,
              label: "Endereço",
              validator: (value) => Validators(value)
                  .setErroMessage("Endereço inválido")
                  .isNotNull()
                  .isNotEmpty()
                  .isMinLengh(3)
                  .isMaxLengh(200)
                  .apply(),
            ),
            _buildField(
              controller: _descriptionController,
              label: "Descrição",
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.check),
                label: const Text("Salvar"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
    int maxLines = 1,
    int? maxLength,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: validator,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final company = Company(
      name: _nameController.text,
      cnpj: _cnpjController.text,
      addressString: _addressController.text,
      description: _descriptionController.text,
    );

    final repository = DomainRepositoryFactory().getRepository<DomainCompanyRepository>();

    repository.create(company).then((_) {
      if (!mounted) return;
      Navigator.pop(context, true);
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text('Empresa criada com sucesso!'),
        ),
      );
    }).onError((error, _) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Erro'),
          content: Text('Falha ao criar empresa: $error'),
        ),
      );
    });
  }
}
