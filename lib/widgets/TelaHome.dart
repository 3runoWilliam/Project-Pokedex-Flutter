import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/widgets/TelaCaptura.dart';
import 'package:project_pokedex_flutter/widgets/TelaPokemonsCapturados.dart';
import 'package:project_pokedex_flutter/widgets/TelaSobre.dart'; // Importe a tela Sobre

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _selectedIndex = 0;
  List<Widget> _telas = [
    TelaHomeConteudo(),
    TelaCaptura(),
    TelaPokemonCapturado(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('POKEAPI EM FLUTTER'),
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Captura',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon),
            label: 'Capturados',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class TelaHomeConteudo extends StatelessWidget {
  const TelaHomeConteudo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Project PokeAPI for PDM',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaSobre()),
              );
            },
            child: const Text('Sobre os Desenvolvedores'),
          ),
        ],
      ),
    );
  }
}
