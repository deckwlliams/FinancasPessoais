import 'package:flutter/material.dart';

class NovaTransacaoForm extends StatefulWidget {
  final Function(String, double, bool) onSubmit;
  final bool isReceitaInicial;

  const NovaTransacaoForm({
    super.key,
    required this.onSubmit,
    required this.isReceitaInicial,
  });

  @override
  State<NovaTransacaoForm> createState() => _NovaTransacaoFormState();
}

class _NovaTransacaoFormState extends State<NovaTransacaoForm> {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();
  late bool isReceita;

  @override
  void initState() {
    super.initState();
    isReceita = widget.isReceitaInicial;
  }

  void submit() {
    final titulo = tituloController.text.trim();
    final valor =
        double.tryParse(valorController.text.replaceAll(',', '.')) ?? 0;

    if (titulo.isEmpty || valor <= 0) return;

    widget.onSubmit(titulo, valor, isReceita);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isReceita ? 'Nova Entrada' : 'Nova Saída',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: valorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Valor'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
