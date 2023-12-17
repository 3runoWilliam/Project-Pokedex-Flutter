import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:project_pokedex_flutter/helpers/pokemon_database_helper.dart';
import 'package:project_pokedex_flutter/widgets/TelaDetalhesPokemon.dart';
import 'package:project_pokedex_flutter/widgets/TelaSoltarPokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  @override
  _TelaPokemonCapturadoState createState() => _TelaPokemonCapturadoState();
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  late Future<List<Pokemon>> _capturedPokemonList;

  @override
  void initState() {
    super.initState();
    _capturedPokemonList = _fetchCapturedPokemons();
  }

  Future<List<Pokemon>> _fetchCapturedPokemons() async {
    final db = await PokemonDatabaseHelper().pokemonDatabase;
    return (await db.pokemonDao.findAllPokemons()) ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémons Capturados'),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _capturedPokemonList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar Pokémons capturados.'));
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return Center(child: Text('Nenhum Pokémon capturado ainda.'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final pokemon = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    // Navegar para TelaDetalhesPokemon
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaDetalhesPokemon(pokemon: pokemon, id: 0,),
                      ),
                    );
                  },
                  onLongPress: () {
                    // Navegar para TelaSoltarPokemon
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaSoltarPokemon(pokemon: pokemon),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(pokemon.nome),
                    // Adicione outros detalhes do Pokémon conforme necessário
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Erro desconhecido.'));
          }
        },
      ),
    );
  }
}