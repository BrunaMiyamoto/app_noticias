import 'dart:io';

import 'package:app_noticias/model/noticia.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastrarNoticiasPage extends StatefulWidget {
  final Noticia? noticia;
  const CadastrarNoticiasPage({super.key, this.noticia});

  @override
  State<CadastrarNoticiasPage> createState() => _CadastrarNoticiasPageState();
}

class _CadastrarNoticiasPageState extends State<CadastrarNoticiasPage> {
  final ImagePicker _picker = ImagePicker();

  File? _imagemSelecionada;

  Future<void> _selecionarImagem(ImageSource origem) async {
    final XFile? foto = await _picker.pickImage(
      source: origem,
      imageQuality: 80,
    );

    if (foto != null) {
      setState(() {
        _imagemSelecionada = File(foto.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Noticia"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          TextFormField(
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              labelText: "Titulo",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          TextFormField(
            maxLines: 3,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              labelText: "Resumo",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          TextFormField(
            maxLines: 5,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(),
              labelText: "Conteudo",
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),

          //outros campos
          const SizedBox(
            height: 15,
          ),
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFD7D7D7),
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(5),
            ),
            child: _imagemSelecionada != null
                ? Image.file(
                    _imagemSelecionada!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : (widget.noticia != null && widget.noticia!.imagem != null)
                ? Image.network(
                    widget.noticia!.imagem!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, erro, stack) => const Center(
                      child: Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : const Center(
                    child: Icon(
                      Icons.image_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ),
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _selecionarImagem(ImageSource.camera),
                  icon: const Icon(
                    Icons.camera_alt,
                  ),
                  label: const Text("Câmera"),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _selecionarImagem(ImageSource.gallery),
                  icon: const Icon(
                    Icons.photo_library,
                  ),
                  label: const Text("Galeria"),
                ),
              ),
            ],
          ),

          //outros campos
          const ListTile(
            title: Text("Categoria"),
          ),

          const ListTile(
            title: Text("Publicação Ativa"),
            //subtitle: SwitchListTile(value: value, onChanged: onChanged),
          ),
        ],
      ),
    );
  }
}
