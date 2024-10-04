import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/personagens.dart';

class Telalistapersonagens extends StatelessWidget {
  const Telalistapersonagens({super.key});

Future<List<Personagem>> pageData() async{
  final response = await http.Client().get(Uri.parse("https://rickandmortyapi.com/api/character"));
  if (response.statusCode == 200){
    var dados = json.decode(response.body);
    List dados_result = dados ['results'] as List;
    List <Personagem> todosPersonagens = [];
    //  debugPrint(" Dados: $dados_result");
    dados_result.forEach((personagem) {todosPersonagens.add(Personagem(id: personagem["id"], name: personagem["name"], status: personagem["status"], species: personagem["species"], type: personagem["type"], gender: personagem["gender"], image: personagem["image"], episode: [], url: personagem["url"], created: personagem["created"]));});
      debugPrint("dados $todosPersonagens");
      todosPersonagens.forEach((x) { debugPrint("Nome: ${x.name}");});
      return todosPersonagens;
  } else {
    debugPrint("Deu erro na conexão");
  }

  return [];
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Personagens"),
      ),
      body:  FutureBuilder(
      future: pageData(), 
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text("Não há nada para retornar");
        } else{
          List<Personagem> listaPersonagens = snapshot.data as List<Personagem>;
          return ListView.builder(
            itemCount: listaPersonagens.length,
            itemBuilder: (context, index) {
              return Text("Nome do personagem: " + listaPersonagens[index].name.toString());
            });
        }
  }),
  );
  }
}
