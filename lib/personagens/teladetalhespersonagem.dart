import 'package:flutter/material.dart';
import 'package:projeto_aula/model/personagem.dart';


class TelaDetalhesPersonagem extends StatelessWidget {
  final Personagem personagem;

  const TelaDetalhesPersonagem({super.key, required this.personagem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personagem.name),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(personagem.image),
            Text(personagem.name),
            Text(personagem.status),
            Text(personagem.species),
            Text(personagem.gender),
          ],
        ),
      ),
    );
  }
}
