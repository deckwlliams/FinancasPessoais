import 'package:flutter/material.dart';
import '/widgets/nova_transacao_form.dart';

class HomePage extends StatelessWidget {
  final Function(String, double, bool) onAdd;

  const HomePage({
    super.key,
    required this.onAdd, required void Function(double entradas, double saidas) onUpdate,
  });

  void _abrirFormulario(BuildContext context, bool isReceita) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return NovaTransacaoForm(
          onSubmit: (titulo, valor, _) {
            onAdd(titulo, valor, isReceita);
          },
        );
      },
    );
  }

  void _abrirOpcoes(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.arrow_upward, color: Colors.green),
              title: const Text('Adicionar Entrada'),
              onTap: () {
                Navigator.pop(context);
                _abrirFormulario(context, true);
              },
            ),
            ListTile(
              leading: const Icon(Icons.arrow_downward, color: Colors.red),
              title: const Text('Adicionar Saída'),
              onTap: () {
                Navigator.pop(context);
                _abrirFormulario(context, false);
              },
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Finanças'),
        centerTitle: true,
      ),

      // 🔘 BOTÃO FLUTUANTE COM AS DUAS OPÇÕES
      floatingActionButton: FloatingActionButton(
        onPressed: () => _abrirOpcoes(context),
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _saldoCard(),
            const SizedBox(height: 16),
            _resumoRow(),
            const SizedBox(height: 24),
            _acoesTitulo(),
            const SizedBox(height: 12),
            _acoesGrid(),
          ],
        ),
      ),
    );
  }

  // 🔹 CARD DE SALDO
  Widget _saldoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saldo Atual',
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'R\$ 0,00',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 RESUMO
  Widget _resumoRow() {
    return Row(
      children: [
        _resumoCard(
          titulo: 'Entradas',
          valor: 'R\$ 0,00',
          cor: Colors.green,
          icone: Icons.arrow_upward,
        ),
        const SizedBox(width: 12),
        _resumoCard(
          titulo: 'Saídas',
          valor: 'R\$ 0,00',
          cor: Colors.red,
          icone: Icons.arrow_downward,
        ),
      ],
    );
  }

  Widget _resumoCard({
    required String titulo,
    required String valor,
    required Color cor,
    required IconData icone,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icone, color: cor),
            const SizedBox(height: 8),
            Text(
              titulo,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              valor,
              style: TextStyle(color: cor),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 TÍTULO
  Widget _acoesTitulo() {
    return const Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Ações rápidas',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 🔹 GRID
  Widget _acoesGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: const [
          _AcaoCard(
            titulo: 'Adicionar Entrada',
            icone: Icons.add_circle,
            cor: Colors.green,
          ),
          _AcaoCard(
            titulo: 'Adicionar Saída',
            icone: Icons.remove_circle,
            cor: Colors.red,
          ),
          _AcaoCard(
            titulo: 'Resumo',
            icone: Icons.bar_chart,
            cor: Colors.blue,
          ),
          _AcaoCard(
            titulo: 'Configurações',
            icone: Icons.settings,
            cor: Colors.grey,
          ),
        ],
      ),
    );
  }
}

// 🔹 CARD DE AÇÃO
class _AcaoCard extends StatelessWidget {
  final String titulo;
  final IconData icone;
  final Color cor;

  const _AcaoCard({
    required this.titulo,
    required this.icone,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icone, size: 40, color: cor),
            const SizedBox(height: 12),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
    