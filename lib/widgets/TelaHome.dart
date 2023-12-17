import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/widgets/TelaCaptura.dart';
import 'package:project_pokedex_flutter/widgets/TelaPokemonsCapturados.dart'; // Importe a tela de captura

class TelaHome extends StatelessWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Informações sobre o Aplicativo',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaCaptura()),
                );
              },
              child: Text('Ir para a Tela de Captura'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaPokemonCapturado()),
                );
              },
              child: Text('Ver Pokémons Capturados'),
            ),
          ],
        ),
      ),
    );
  }
}
