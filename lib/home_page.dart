import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<String> categorias = [
    "Todas",
    "Programação",
    "Claude"
        "Hardware",
    "Cibersegurança",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/img/logotipo.png",
          height: 20,
        ),
        centerTitle: true,
        actions: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ], //inserir lupa
      ),
      drawer: const Drawer(),
      body: Column(
        children: [
          //se aparecer um erro no listview, clicar na lâmpada e remover const
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection:
                  Axis.horizontal, //deixa os elementos na horizontal
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: categorias.map((categoria) {
                //remove os colchetes do children e chama a lista que criamos e categoria
                final selecionada = categoria == "Todas";
                return Container(
                  margin: const EdgeInsets.only(
                    right: 8,
                  ), //formatação de margin individual
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: selecionada
                          ? Colors.black
                          : const Color(0xFFEDEDED),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    categoria,
                    style: const TextStyle(fontSize: 12),
                  ),
                ); //clicamos no Text e adicionamos o container com o wrap na lâmpada
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
