import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ResumoPage extends StatelessWidget {
  final double totalEntradas;
  final double totalSaidas;

  const ResumoPage(
      {super.key, required this.totalEntradas, required this.totalSaidas});

  @override
  Widget build(BuildContext context) {
    final double maxBarra =
        (totalEntradas > totalSaidas ? totalEntradas : totalSaidas) + 100;

    return Scaffold(
      appBar: AppBar(title: const Text('Resumo'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BarChart(
          BarChartData(
            maxY: maxBarra,
            barGroups: [
              BarChartGroupData(
                x: 0,
                barRods: [
                  BarChartRodData(
                      toY: totalEntradas,
                      color: Colors.green,
                      width: 30,
                      borderRadius: BorderRadius.circular(8))
                ],
              ),
              BarChartGroupData(
                x: 1,
                barRods: [
                  BarChartRodData(
                      toY: totalSaidas,
                      color: Colors.red,
                      width: 30,
                      borderRadius: BorderRadius.circular(8))
                ],
              ),
            ],
            titlesData: FlTitlesData(
              leftTitles:
                  const AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    if (value == 0) return const Text('Ganhos');
                    if (value == 1) return const Text('Despesas');
                    return const Text('');
                  },
                ),
              ),
            ),
            borderData: FlBorderData(show: false),
            gridData: const FlGridData(show: false),
          ),
        ),
      ),
    );
  }
}
