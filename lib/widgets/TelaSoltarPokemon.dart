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
        title: Text('Soltar Pokémon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: ${pokemon.nome}'),
            Text('ID: ${pokemon.id}'),
            // Adicione outros detalhes do Pokémon conforme necessário
            SizedBox(height: 16),
            Image.network(pokemon.urlImagem), // Exemplo de exibição de imagem
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para confirmar a soltura do Pokémon (excluir do banco de dados)
                    _confirmarSoltura(context, pokemon);
                  },
                  child: Text('Confirmar'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Voltar à tela anterior sem soltar o Pokémon
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
    final deuCerto = await pokemonDatabase.pokemonDao.deletePokemon(pokemon);

    bool sucesso;

    try {
      sucesso = await pokemonDatabase.pokemonDao.deletePokemon(pokemon) > 0;
    } catch (e) {
      sucesso = false;
    }

    if (sucesso) {
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao soltar o Pokémon. Tente novamente.'),
        ),
      );
    }
  }
}
