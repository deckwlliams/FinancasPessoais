import 'dart:convert';

class Transacao {
  final String titulo;
  final double valor;
  final bool isReceita;

  Transacao({
    required this.titulo,
    required this.valor,
    required this.isReceita,
    required DateTime data,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'valor': valor,
      'isReceita': isReceita,
    };
  }

  factory Transacao.fromMap(Map<String, dynamic> map) {
    return Transacao(
        titulo: map['titulo'],
        valor: map['valor'],
        isReceita: map['isReceita'],
        data: DateTime.parse(map['data']));
  }

  static String encode(List<Transacao> lista) =>
      jsonEncode(lista.map((e) => e.toMap()).toList());

  static List<Transacao> decode(String json) =>
      (jsonDecode(json) as List).map((e) => Transacao.fromMap(e)).toList();
}
