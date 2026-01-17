import 'package:flutter/material.dart';

class Financa {
  final String descricao;
  final double valor;
  final bool isEntrada;

  Financa(
      {required this.descricao, required this.valor, required this.isEntrada});
}

class HomePage extends StatefulWidget {
  final Function(double, double)? onUpdate;

  const HomePage({super.key, this.onUpdate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Financa> _financas = [];

  double get totalEntradas =>
      _financas.where((f) => f.isEntrada).fold(0, (sum, f) => sum + f.valor);
  double get totalSaidas =>
      _financas.where((f) => !f.isEntrada).fold(0, (sum, f) => sum + f.valor);
  double get saldo => totalEntradas - totalSaidas;

  void _notificarResumo() {
    widget.onUpdate?.call(totalEntradas, totalSaidas);
  }

  void _adicionarFinanca(Financa f) {
    setState(() {
      _financas.add(f);
      _notificarResumo();
    });
  }

  void _editarFinanca(int index, Financa f) {
    setState(() {
      _financas[index] = f;
      _notificarResumo();
    });
  }

  void _removerFinanca(int index) {
    setState(() {
      _financas.removeAt(index);
      _notificarResumo();
    });
  }

  void _abrirFormulario({Financa? financa, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => FinanceForm(
        financa: financa,
        onSalvar: (nova) {
          if (index == null) {
            _adicionarFinanca(nova);
          } else {
            _editarFinanca(index, nova);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Finanças')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirFormulario(),
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [Colors.green.shade700, Colors.green.shade400],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Saldo atual',
                      style: TextStyle(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('R\$ ${saldo.toStringAsFixed(2)}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Expanded(
            child: _financas.isEmpty
                ? const Center(child: Text('Nenhuma finança cadastrada'))
                : ListView.builder(
                    itemCount: _financas.length,
                    itemBuilder: (context, index) {
                      final f = _financas[index];
                      return Dismissible(
                        key: ValueKey('$index${f.descricao}'),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) => _removerFinanca(index),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: ListTile(
                            onTap: () =>
                                _abrirFormulario(financa: f, index: index),
                            leading: Icon(
                                f.isEntrada
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: f.isEntrada ? Colors.green : Colors.red),
                            title: Text(f.descricao),
                            trailing: Text(
                                '${f.isEntrada ? '+' : '-'} R\$ ${f.valor.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color:
                                        f.isEntrada ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class FinanceForm extends StatefulWidget {
  final Financa? financa;
  final Function(Financa) onSalvar;

  const FinanceForm({super.key, this.financa, required this.onSalvar});

  @override
  State<FinanceForm> createState() => _FinanceFormState();
}

class _FinanceFormState extends State<FinanceForm> {
  late TextEditingController _descricaoController;
  late TextEditingController _valorController;
  late bool _isEntrada;

  @override
  void initState() {
    super.initState();
    _descricaoController =
        TextEditingController(text: widget.financa?.descricao ?? '');
    _valorController =
        TextEditingController(text: widget.financa?.valor.toString() ?? '');
    _isEntrada = widget.financa?.isEntrada ?? true;
  }

  void _salvar() {
    final descricao = _descricaoController.text.trim();
    final valor = double.tryParse(_valorController.text.replaceAll(',', '.'));
    if (descricao.isEmpty || valor == null || valor <= 0) return;

    widget.onSalvar(
        Financa(descricao: descricao, valor: valor, isEntrada: _isEntrada));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.financa == null ? 'Nova Finança' : 'Editar Finança',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
              controller: _descricaoController,
              decoration: const InputDecoration(labelText: 'Descrição')),
          const SizedBox(height: 8),
          TextField(
              controller: _valorController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Valor')),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('É um ganho?'),
            value: _isEntrada,
            onChanged: (v) => setState(() => _isEntrada = v),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: _salvar, child: const Text('Salvar')),
        ],
      ),
    );
  }
}
