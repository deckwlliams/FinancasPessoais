import 'dart:convert';

class Financa {
  final String descricao;
  final double valor;
  final bool isReceita;

  Financa({
    required this.descricao,
    required this.valor,
    required this.isReceita,
  });

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
      'valor': valor,
      'isReceita': isReceita,
    };
  }

  factory Financa.fromMap(Map<String, dynamic> map) {
    return Financa(
      descricao: map['descricao'],
      valor: map['valor'],
      isReceita: map['isReceita'],
    );
  }

  static String encode(List<Financa> lista) =>
      jsonEncode(lista.map((e) => e.toMap()).toList());

  static List<Financa> decode(String lista) =>
      (jsonDecode(lista) as List)
          .map((e) => Financa.fromMap(e))
          .toList();
}
