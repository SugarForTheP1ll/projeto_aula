import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/personagem.dart';
import '../personagens/teladetalhespersonagem.dart';

class Telalistapersonagens extends StatelessWidget {
  const Telalistapersonagens({super.key});
  

  Future<List<Personagem>> pageData() async {
    final response = await http.Client()
        .get(Uri.parse("https://rickandmortyapi.com/api/character"));

    if (response.statusCode == 200) {
      try {
        var dados = json.decode(response.body);
        List dadosResult = dados['results'] as List;
        List<Personagem> todosPersonagens = [];

        dadosResult.forEach(
          (personagem) {
            debugPrint("Dados; $personagem");
            Personagem p = Personagem(
              id: personagem['id'],
              name: personagem['name'],
              status: personagem['status'],
              species: personagem['species'],
              gender: personagem['gender'],
              location: personagem['location']['name'], // Corrigido
              image: personagem['image'],
              episodes: [],
              url: personagem['url'],
              created: personagem['created'],
              type: personagem['type'],
            );

            todosPersonagens.add(p);
          },
        );
        return todosPersonagens;
      } catch (e) {
        debugPrint("Erro ao decodificar os dados: $e");
        return [];
      }
    } else {
      debugPrint("Erro na conexão: ${response.statusCode}");
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Personagens"),
      ),
      body: FutureBuilder(
        future: pageData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List<Personagem>).isEmpty) {
            return const Center(child: Text("Não há dados para exibir"));
          } else {
            List<Personagem> listaPersonagens = snapshot.data as List<Personagem>;
            return ListView.builder(
              itemCount: listaPersonagens.length,
              itemBuilder: (context, index) {
                Color cor = Colors.green;
                if (listaPersonagens[index].status == "unknown") {
                  cor = Colors.yellow;
                } else if (listaPersonagens[index].status == "Alive") {
                  cor = Colors.green;
                } else {
                  cor = Colors.red;
                }

                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalhesPersonagem(personagem: listaPersonagens[index]),
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(listaPersonagens[index].image),
                      ),
                      title: Text(listaPersonagens[index].name),
                      subtitle: Text(listaPersonagens[index].species),
                      trailing: Icon(
                        Icons.circle,
                        color: cor,
                        size: 15.0,
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
