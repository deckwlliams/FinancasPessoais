import 'package:flutter/material.dart';
import 'home_page.dart';
import 'resumo_page.dart';
import 'settings_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _index = 0;

  double totalEntradas = 0;
  double totalSaidas = 0;

  void atualizarResumo(double entradas, double saidas) {
    setState(() {
      totalEntradas = entradas;
      totalSaidas = saidas;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onUpdate: atualizarResumo),
      ResumoPage(totalEntradas: totalEntradas, totalSaidas: totalSaidas),
      const SettingsPage(),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Resumo'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
        ],
      ),
    );
  }
}
