import 'package:flutter/material.dart';
import 'package:project_pokedex_flutter/database/pokemon_database.dart';
import 'package:project_pokedex_flutter/domain/Pokemons.dart';

class TelaSoltarPokemon extends StatelessWidget {
  final Pokemon pokemon;

  TelaSoltarPokemon({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soltar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${pokemon.nome}'),
            Text('ID: ${pokemon.id}'),
            SizedBox(height: 16),
            Image.network(pokemon.urlImagem),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _confirmarSoltura(context, pokemon);
                  },
                  child: Text('Confirmar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmarSoltura(BuildContext context, Pokemon pokemon) async {
    final pokemonDatabase = await $FloorPokemonDatabase
        .databaseBuilder('pokemon_database.db')
        .build();

    try {
      final deuCerto = await pokemonDatabase.pokemonDao.deletePokemon(pokemon);

      if (deuCerto != null && deuCerto > 0) {
        Navigator.of(context).pop(true); // Retorna true indicando sucesso
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao soltar o Pokémon. Tente novamente.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao soltar o Pokémon. Tente novamente.'),
        ),
      );
    }
  }
}
