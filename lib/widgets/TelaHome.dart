import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/widgets/TelaCaptura.dart';
import 'package:project_pokedex_flutter/widgets/TelaPokemonsCapturados.dart';
import 'package:project_pokedex_flutter/widgets/TelaSobre.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  _TelaHomeState createState() => _TelaHomeState();
}

class _TelaHomeState extends State<TelaHome> {
  int _selectedIndex = 0;
  final List<Widget> _telas = [
    const TelaHomeConteudo(),
    TelaCaptura(),
    TelaPokemonCapturado(),
    TelaSobre(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PokeAPI em Flutter'),
      ),
      body: _telas[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.red, // Defina a cor de fundo aqui
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
          BottomNavigationBarItem(
            icon: Icon(Icons.admin_panel_settings),
            label: 'Sobre',
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
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Project PokeAPI for PDM',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
