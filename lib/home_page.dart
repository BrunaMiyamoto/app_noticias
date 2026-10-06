import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static final List<Map<String, String>> noticias = [
    {
      'titulo': 'Nova tecnologia promete transformar o mercado',
      'resumo':
          'Uma nova solução tecnológica está chamando a atenção de empresas e especialistas.',
      'categoria': 'Tecnologia',
      'data': '06/10/2026',
    },
    {
      'titulo': 'Brasil anuncia novos investimentos em educação',
      'resumo':
          'O governo anunciou um novo pacote de investimentos para melhorar a infraestrutura das escolas.',
      'categoria': 'Educação',
      'data': '05/10/2026',
    },
    {
      'titulo': 'Mercado financeiro apresenta alta nesta semana',
      'resumo':
          'Os principais índices registraram crescimento após novos dados econômicos positivos.',
      'categoria': 'Economia',
      'data': '04/10/2026',
    },
    {
      'titulo': 'Equipe brasileira conquista título internacional',
      'resumo':
          'A equipe venceu a final em uma partida emocionante e garantiu o troféu.',
      'categoria': 'Esportes',
      'data': '03/10/2026',
    },
    {
      'titulo': 'Festival cultural reúne milhares de pessoas',
      'resumo':
          'O evento contou com música, gastronomia e diversas atrações culturais durante o fim de semana.',
      'categoria': 'Cultura',
      'data': '02/10/2026',
    },
  ];

  static final List<String> categorias = [
    "Todas",
    "Tecnologia",
    "Educação",
    "Economia",
    "Esporte",
    "Cultura",
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: noticias.length,
              itemBuilder: (context, index) {
                final noticia = noticias[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: Colors.white,
                  elevation: 0, // remove a sombra
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Color(0xFFCBD2D9)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 120,
                        color: const Color(0xFFE4e9EF),
                        child: const Icon(Icons.image_outlined),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text("Tecnologia"),
                                SizedBox(
                                  width: 15,
                                ),
                                Text("06/10/2026"),
                              ],
                            ),
                            Text(
                              "O governo anunciou um novo pacote de investimentos para melhorar a infraestrutura das escolas.",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
