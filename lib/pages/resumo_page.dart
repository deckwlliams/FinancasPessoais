import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transacao.dart';

class ResumoPage extends StatelessWidget {
  final List<Transacao> transacoes;
  final double totalEntradas;
  final double totalSaidas;

  const ResumoPage({
    super.key,
    required this.transacoes,
    required this.totalEntradas,
    required this.totalSaidas,
  });

  double get saldo => totalEntradas - totalSaidas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resumo')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _saldoCard(),
          const SizedBox(height: 16),
          _grafico(),
          const SizedBox(height: 24),
          const Text(
            'Últimas transações',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...transacoes.reversed.take(5).map(_transacaoTile),
        ],
      ),
    );
  }

  Widget _saldoCard() {
    return Card(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Saldo Atual', style: TextStyle(color: Colors.white70)),
            Text(
              'R\$ ${saldo.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _grafico() {
    if (totalEntradas == 0 && totalSaidas == 0) {
      return const Center(child: Text('Sem dados'));
    }

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(sections: [
          PieChartSectionData(
            value: totalEntradas,
            title: 'Entradas',
            color: Colors.green,
          ),
          PieChartSectionData(
            value: totalSaidas,
            title: 'Saídas',
            color: Colors.red,
          ),
        ]),
      ),
    );
  }

  Widget _transacaoTile(Transacao t) {
    return ListTile(
      leading: Icon(
        t.isReceita ? Icons.arrow_upward : Icons.arrow_downward,
        color: t.isReceita ? Colors.green : Colors.red,
      ),
      title: Text(t.titulo),
      trailing: Text(
        'R\$ ${t.valor.toStringAsFixed(2)}',
        style: TextStyle(
          color: t.isReceita ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
