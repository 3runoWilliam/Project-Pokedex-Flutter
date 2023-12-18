import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:project_pokedex_flutter/helpers/pokemon_database_helper.dart';
import 'package:project_pokedex_flutter/widgets/TelaDetalhesPokemon.dart';
import 'package:project_pokedex_flutter/widgets/TelaSoltarPokemon.dart';

class TelaPokemonCapturado extends StatefulWidget {
  @override
  _TelaPokemonCapturadoState createState() => _TelaPokemonCapturadoState();

  static _TelaPokemonCapturadoState? of(BuildContext context) {
    return context.findAncestorStateOfType<_TelaPokemonCapturadoState>();
  }
}

class _TelaPokemonCapturadoState extends State<TelaPokemonCapturado> {
  late Future<List<Pokemon>> _capturedPokemonList;
  late PokemonDatabaseHelper _pokemonDatabaseHelper;

  @override
  void initState() {
    super.initState();
    _pokemonDatabaseHelper = PokemonDatabaseHelper();
    _capturedPokemonList = _fetchCapturedPokemons();
  }

  Future<List<Pokemon>> _fetchCapturedPokemons() async {
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    return (await db.pokemonDao.findAllPokemons()) ?? [];
  }

  // Método para adicionar um Pokémon capturado à lista
  Future<void> adicionarPokemonCapturado(Pokemon pokemon) async {
    // Atualize a lista diretamente no banco de dados
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    await db.pokemonDao.insertPokemon(pokemon);

    setState(() {
      // Recarregue a lista após adicionar um Pokémon
      _capturedPokemonList = _fetchCapturedPokemons();
    });
  }

  // Método para remover um Pokémon capturado da lista
  Future<void> removerPokemonCapturado(Pokemon pokemon) async {
    // Remova o Pokémon diretamente do banco de dados
    final db = await _pokemonDatabaseHelper.pokemonDatabase;
    await db.pokemonDao.deletePokemon(pokemon);

    setState(() {
      // Recarregue a lista após remover um Pokémon
      _capturedPokemonList = _fetchCapturedPokemons();
    });
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
                        builder: (context) => TelaDetalhesPokemon(
                          id: pokemon.id,
                          pokemon: pokemon,
                        ),
                      ),
                    );
                  },
                  onLongPress: () async {
                    // Navegar para TelaSoltarPokemon e aguardar um resultado
                    final resultado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaSoltarPokemon(pokemon: pokemon),
                      ),
                    );

                    // Se o resultado for true, remover o Pokémon da lista
                    if (resultado == true) {
                      await removerPokemonCapturado(pokemon);
                    }
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
