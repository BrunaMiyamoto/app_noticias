import 'dart:convert';
import 'dart:io';

import 'package:app_noticias/model/noticia.dart';
import 'package:app_noticias/services/login_services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class NoticiaService {
  final LoginServices _loginServices =
      LoginServices(); //toda vez que eu chamo um arquivo estou chamando junto as funções desse arquivo, nesse caso o login services
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

  Future<void> criarNoticia({
    required String titulo,
    required String resumo,
    required String conteudo,
    required int categoriaId,
    required bool ativo,
    File? imagemArquivo,
  }) async {
    try {
      final token = await _loginServices.getToken();
      if (imagemArquivo != null) {
        final request = http.MultipartRequest(
          'POST',
          Uri.parse("$baseUrl/noticias"),
        ); // usaremos esse multipart pq ele permite anexar arquivos

        request.headers['Accept'] = 'application/json';
        request.headers['Authorization'] = 'bearer $token';
        request.fields['titulo'] =
            titulo; //nomes precisam ser iguais ao nomes que estão no laravel
        request.fields['resumo'] = resumo;
        request.fields['conteudo'] = conteudo;
        request.fields['categoria_id'] = categoriaId.toString();
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagemArquivo.path),
        );
        request.fields['ativo'] = ativo ? '1' : '0';

        final resposta = await request
            .send(); //enviar para a API, manda lá para o laravel

        final corpoResposta = await resposta.stream
            .bytesToString(); // bytesToString converte os caracteres em texto
        print('Status: ${resposta.statusCode}');
        print('Resposta da Api: $corpoResposta');

        //print(resposta);//verificar erros

        if (resposta.statusCode != 200 && resposta.statusCode != 201) {
          throw Exception("Todos os campos são obrigatórios");
        }
      } else {
        throw Exception("Todos os campos são obrigatórios");
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> editarNoticia({
    required int id,
    required String titulo,
    required String resumo,
    required String conteudo,
    required int categoriaId,
    required bool ativo,

    File? imagemArquivo,
  }) async {
    try {
      final token = await _loginServices.getToken();

      final request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/noticias/$id"),
      ); // usaremos esse multipart pq ele permite anexar arquivos

      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'bearer $token';
      request.fields['_method'] =
          'PUT'; //adicionamos o metodo porque na rota da api usamos o método put para adicionar a noticia
      request.fields['titulo'] =
          titulo; //nomes precisam ser iguais ao nomes que estão no laravel
      request.fields['resumo'] = resumo;
      request.fields['conteudo'] = conteudo;
      request.fields['categoria_id'] = categoriaId.toString();
      request.fields['ativo'] = ativo ? '1' : '0';

      //request fields['ativo'] = ativo;

      if (imagemArquivo != null) {
        request.files.add(
          await http.MultipartFile.fromPath('imagem', imagemArquivo.path),
        );
      }

      final resposta = await request
          .send(); //enviar para a API, manda lá para o laravel

      //print(resposta);//verificar erros

      final corpoResposta = await resposta.stream
          .bytesToString(); // bytesToString converte os caracteres em texto

      print('Status: ${resposta.statusCode}');
      print('Resposta da Api: $corpoResposta');

      if (resposta.statusCode != 200 && resposta.statusCode != 201) {
        throw Exception("Todos os campos são obrigatórios");
      }
    } catch (e) {
      throw Exception('$e');
    }
  }

  Future<void> excluirNoticia(int id) async {
    try {
      final token = await _loginServices.getToken();

      final resposta = await http.delete(
        Uri.parse('$baseUrl/noticias/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (resposta.statusCode != 200 && resposta.statusCode != 204) {
        throw Exception("Não foi Possível excluir a notícia.");
      }
    } catch (e) {
      throw Exception('$e');
    }
  }
}
