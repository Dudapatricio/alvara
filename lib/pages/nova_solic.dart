import 'package:flutter/material.dart';

class NovaSolicitacao extends StatefulWidget {
  const NovaSolicitacao({super.key});

  @override
  _NovaSolicitacaoState createState() => _NovaSolicitacaoState();
}

class _NovaSolicitacaoState extends State<NovaSolicitacao> {
  final _formKey = GlobalKey<FormState>();

  final _nomeEmpresaController = TextEditingController();
  final _cnpjController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _descricaoController = TextEditingController();

  String? _tipoAlvara;

  @override
  void dispose() {
    _nomeEmpresaController.dispose();
    _cnpjController.dispose();
    _enderecoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _enviar() {
    if (_formKey.currentState!.validate()) {
      if (_tipoAlvara == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione o tipo de alvará')),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitação enviada com sucesso!')),
      );

      _formKey.currentState!.reset();
      setState(() {
        _tipoAlvara = null;
      });
      _nomeEmpresaController.clear();
      _cnpjController.clear();
      _enderecoController.clear();
      _descricaoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nova Solicitação de Alvará')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeEmpresaController,
                decoration: const InputDecoration(labelText: 'Nome da Empresa'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o nome da empresa';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cnpjController,
                decoration: const InputDecoration(labelText: 'CNPJ'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o CNPJ';
                  }
                  if (value.length != 14) {
                    return 'CNPJ deve ter 14 dígitos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _enderecoController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe o endereço';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(labelText: 'Descrição da Atividade'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Descreva a atividade';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Tipo de Alvará'),
                value: _tipoAlvara,
                items: const [
                  DropdownMenuItem(value: 'Comercial', child: Text('Comercial')),
                  DropdownMenuItem(value: 'Industrial', child: Text('Industrial')),
                  DropdownMenuItem(value: 'Residencial', child: Text('Residencial')),
                ],
                onChanged: (value) {
                  setState(() {
                    _tipoAlvara = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Selecione o tipo de alvará';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _enviar,
                child: const Text('Enviar Solicitação'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

