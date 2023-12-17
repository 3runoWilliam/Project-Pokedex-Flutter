import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:project_pokedex_flutter/helpers/PokeApiHelper.dart';
import 'package:project_pokedex_flutter/helpers/pokemon_database_helper.dart';

class TelaDetalhesPokemon extends StatefulWidget {
  final int id;

  // Corrija o construtor para receber o parâmetro Pokemon como opcional
  TelaDetalhesPokemon({required this.id, Pokemon? pokemon})
      : _pokemon = pokemon;

  final Pokemon? _pokemon;

  @override
  _TelaDetalhesPokemonState createState() => _TelaDetalhesPokemonState();
}

class _TelaDetalhesPokemonState extends State<TelaDetalhesPokemon> {
  late Future<Pokemon> _pokemonDetails;
  final PokemonApiHelper _pokemonApiHelper = PokemonApiHelper();

  @override
  void initState() {
    super.initState();
    _pokemonDetails = _fetchPokemonDetails();
  }

  Future<Pokemon> _fetchPokemonDetails() async {
    final localDb = await PokemonDatabaseHelper().pokemonDatabase;
    final localPokemon = await localDb.pokemonDao.findPokemonById(widget.id);

    if (localPokemon != null) {
      return localPokemon;
    }

    final apiPokemon = await _pokemonApiHelper.getPokemonDetails(widget.id);

    if (apiPokemon != null) {
      await localDb.pokemonDao.insertPokemon(apiPokemon);
    }

    return apiPokemon ??
        Pokemon(
            id: widget.id,
            nome: 'Não encontrado',
            tipos: '',
            urlImagem: '',
            baseExperiencia: 0,
            habilidades: '',
            altura: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Pokémon'),
      ),
      body: FutureBuilder<Pokemon>(
        future: _pokemonDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar detalhes do Pokémon.'));
          } else if (snapshot.hasData) {
            final pokemon = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ID: ${pokemon.id}',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Text('Nome: ${pokemon.nome}',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold)),
                  Image.network(pokemon.urlImagem,
                      height: 200.0, width: 200.0, fit: BoxFit.cover),
                  Text('Tipos: ${pokemon.tipos}',
                      style: TextStyle(fontSize: 16.0)),
                  Text('Base de Experiência: ${pokemon.baseExperiencia}',
                      style: TextStyle(fontSize: 16.0)),
                  Text('Habilidades: ${pokemon.habilidades}',
                      style: TextStyle(fontSize: 16.0)),
                  Text('Altura: ${pokemon.altura}',
                      style: TextStyle(fontSize: 16.0)),
                  // Adicione outros detalhes conforme necessário
                ],
              ),
            );
          } else {
            return Center(child: Text('Erro desconhecido.'));
          }
        },
      ),
    );
  }
}
