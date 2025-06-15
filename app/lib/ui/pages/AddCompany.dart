import 'package:flutter/material.dart';

class AddCompany extends StatefulWidget {
  const AddCompany({super.key});

  @override
  State<StatefulWidget> createState() => _AddCompany();
}

class _AddCompany extends State<AddCompany> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
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
                        value == null || value.isEmpty
                            ? "Inform um nome"
                            : null,
                onSaved: (value) => _name = value!,
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
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop();
      _name;
      //Requisição
    }
  }
}
