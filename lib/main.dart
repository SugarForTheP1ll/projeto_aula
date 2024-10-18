import 'package:flutter/material.dart';
import 'package:projeto_aula/locais/Telalistalocais.dart';
import 'episodios/Telalistaepisodios.dart';
import 'personagens/telalistapersonagens.dart';

void main() {
  runApp(MaterialApp(
    title: "Aplicativo do Rick & Morty",
    home: const Home(),
    theme: ThemeData(
      fontFamily: 'Rick and Morty Font',
      brightness: Brightness.dark,
    ),
  ));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Aplicativo do Rick & Morty"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment
                .spaceEvenly, 

            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Telalistapersonagens()));
                },
                child: Column(
                  children: [
                    Image.asset(
                      "images/characters.png",
                      width: 120,
                      height: 120,
                    ),
                    const Text("Personagens", style: TextStyle(fontSize: 48)),
                  ],
                ),
              ),
              GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Telalistaepisodios(), 
                          ));
                    },
                    child: Column(children: [
                      Image.asset(
                        "images/locations.png",
                        width: 120,
                        height: 120,
                      ),
                      const Text("Locais", style: TextStyle(fontSize: 48)),
                    ]),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Telalistalocais(),
                      ));
                },
                child: Column(children: [
                  Image.asset(
                    "images/episodes.png",
                    width: 120,
                    height: 120,
                  ),
                  const Text("Episódios", style: TextStyle(fontSize: 48)),
                ]),
              )
            ],
          ),
        ));
  }
}
