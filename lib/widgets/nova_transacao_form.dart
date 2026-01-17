import 'package:flutter/material.dart';

class NovaTransacaoForm extends StatefulWidget {
  final Function(String, double, bool) onSubmit;

  const NovaTransacaoForm({super.key, required this.onSubmit});

  @override
  State<NovaTransacaoForm> createState() => _NovaTransacaoFormState();
}

class _NovaTransacaoFormState extends State<NovaTransacaoForm> {
  final tituloController = TextEditingController();
  final valorController = TextEditingController();
  bool isReceita = true;

  void submit() {
    final titulo = tituloController.text;
    final valor = double.tryParse(valorController.text) ?? 0;

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
          TextField(
            controller: tituloController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: valorController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Valor'),
          ),
          SwitchListTile(
            title: const Text('É receita?'),
            value: isReceita,
            onChanged: (value) {
              setState(() {
                isReceita = value;
              });
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: submit,
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
