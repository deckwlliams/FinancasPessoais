
import 'package:flutter/material.dart';

class ResumoCard extends StatelessWidget {
  final String titulo;
  final double valor;
  final Color cor;

  const ResumoCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(titulo),
              const SizedBox(height: 8),
              Text(
                'R\$ ${valor.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
