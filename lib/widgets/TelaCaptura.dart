import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:project_pokedex_flutter/helpers/pokemon_database_helper.dart';

class TelaCaptura extends StatefulWidget {
  @override
  _TelaCapturaState createState() => _TelaCapturaState();
}

class _TelaCapturaState extends State<TelaCaptura> {
  late List<Pokemon> _pokemonsCapturados;
  late List<Pokemon> _pokemonsDisponiveis;
  late bool _conectado;
  late PokemonDatabaseHelper _pokemonDatabaseHelper;

  @override
  void initState() {
    super.initState();
    _pokemonsCapturados = [];
    _pokemonsDisponiveis = [];
    _conectado = false;
    _pokemonDatabaseHelper = PokemonDatabaseHelper();
    _verificarConexao();
  }

  Future<void> _verificarConexao() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _conectado = connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    });

    if (_conectado) {
      _carregarPokemonsDisponiveis();
    }
  }

  Future<void> _carregarPokemonsDisponiveis() async {
    // Simule aqui o processo de carregar Pokémons da API
    // Substitua isso pela lógica real de carregamento da API
    List<Pokemon> pokemonsApi = [
      // Pokemon(id: 1, nome: 'Bulbasaur'),
      // Pokemon(id: 4, nome: 'Charmander'),
      // Pokemon(id: 7, nome: 'Squirtle'),
      // Adicione mais Pokémons conforme necessário
    ];

    setState(() {
      _pokemonsDisponiveis = pokemonsApi;
    });
  }

  Future<void> _capturarPokemon(Pokemon pokemon) async {
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    await db.pokemonDao.insertPokemon(pokemon);

    setState(() {
      _pokemonsCapturados.add(pokemon);
    });
  }

  Widget _buildPokemonCard(Pokemon pokemon) {
    bool capturado = _pokemonsCapturados.contains(pokemon);

    return Card(
      child: ListTile(
        title: Text(pokemon.nome),
        subtitle: Text('ID: ${pokemon.id}'),
        trailing: ElevatedButton(
          onPressed: capturado ? null : () => _capturarPokemon(pokemon),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              capturado ? Colors.grey : Colors.red,
            ),
          ),
          child: const Icon(Icons.catching_pokemon),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Capturar Pokémon'),
      ),
      body: _conectado
          ? ListView.builder(
              itemCount: _pokemonsDisponiveis.length,
              itemBuilder: (context, index) {
                return _buildPokemonCard(_pokemonsDisponiveis[index]);
              },
            )
          : const Center(
              child: Text('Sem conexão com a Internet'),
            ),
    );
  }
}
