import 'dart:convert';

import 'package:project_pokedex_flutter/domain/Pokemons.dart';
import 'package:http/http.dart' as http;

class PokemonApiHelper {
  Future<Pokemon?> getPokemonDetails(int id) async {
    final apiUrl = 'https://pokeapi.co/api/v2/pokemon/$id';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Pokemon.fromMap(data);
      } else {
        print('Erro ao buscar dados do Pokémon: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Erro ao buscar dados do Pokémon: $e');
      return null;
    }
  }
}
