import 'package:flutter/material.dart';

class CadastrarNoticiasPage extends StatefulWidget {
  const CadastrarNoticiasPage({super.key});

  @override
  State<CadastrarNoticiasPage> createState() => _CadastrarNoticiasPageState();
}

class _CadastrarNoticiasPageState extends State<CadastrarNoticiasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Noticia"),
      ),
      body: ListView(),
    );
  }
}
