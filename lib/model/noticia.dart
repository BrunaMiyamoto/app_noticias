class Noticia {
  final int id;
  final String titulo;
  final String resumo;
  final String conteudo;
  final String?
  imagem; // ponto de interrogação diz que o atributo pode ser nulo
  final int categoriaId; //onde tinha um underline substituimos por camel case
  final String categoriaNome;
  final DateTime createdAt;

  Noticia({
    required this.id,
    required this.titulo,
    required this.resumo,
    required this.conteudo,
    this.imagem,
    required this.categoriaId,
    required this.categoriaNome,
    required this.createdAt,
  }); //criamos um cronstrutor e os erros que apareciam nas variaveis não inicializadas somem.

  //criamos um laço de repetição que converte as informações (que vem em json) em objetos
  factory Noticia.fromJson(Map<String, dynamic> json) {
    return Noticia(
      id: json["id"],
      titulo: json["titulo"],
      resumo: json["resumo"],
      conteudo: json["conteudo"],
      categoriaId: json["categoria_id"],
      categoriaNome: json["categoria_nome"],
      imagem: json["imagem"],
      createdAt: DateTime.parse(json["created_at"]),
    );
  }

  //para formatar a data que irá aparecer, e colocar o zero a esquerda
  String get dataFormatada {
    final dia = createdAt.day.toString().padLeft(
      2,
      "0",
    ); //corresponde a duas casas decimais e o 0 que irá a esquerda
    final mes = createdAt.month.toString().padLeft(2, '0');
    final ano = createdAt.year.toString();
    return '$dia/$mes/$ano';
  }
}
