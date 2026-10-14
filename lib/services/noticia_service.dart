import 'dart:convert';

import 'package:app_noticias/model/noticia.dart';
import 'package:http/http.dart' as http;

class NoticiaService {
  static const String baseUrl =
      "http://10.0.2.2:8000/api"; //é um caminho, e para que o flutter consiga ler é necessário tracar o ip ao inves do 127 para esse aqui

  //criamos uma função assincrona para o app não travar e ficar carregando
  //depois vamo chamar essa função getnoticia() na nossa homepage
  Future<List<Noticia>> getNoticias() async {
    final resposta = await http.get(Uri.parse('$baseUrl/noticias'));

    if (resposta.statusCode == 200) {
      //esse código é o retornado em caso de sucesso ou erro

      final List dados = jsonDecode(
        resposta.body,
      ); //aqui estamos decodificando as informações em json
      return dados
          .map((item) => Noticia.fromJson(item))
          .toList(); //laço de repetição (map) - converte a noticia em objeto e retorna uma lista de objetos
    } else {
      throw Exception('não foi possível carregar as noticias');
    }
  }
}
