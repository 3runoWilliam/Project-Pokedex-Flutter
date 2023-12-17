// Importe as dependências necessárias
import 'package:floor/floor.dart';

@Entity(tableName: 'pokemon')
class Pokemon {
  @PrimaryKey(autoGenerate: true)
  late final int id;

  final String nome;

  @ColumnInfo(name: 'tipos')
  final String tipos;

  final String urlImagem;
  final int baseExperiencia;
  final String habilidades;

  final double altura;

  Pokemon({
    required this.id,
    required this.nome,
    required this.tipos,
    required this.urlImagem,
    required this.baseExperiencia,
    required this.habilidades,
    required this.altura,
  });

  List<String> getTiposList() {
    return tipos.split(',');
  }

  List<String> getHabilidadesList() {
    return habilidades.split(',');
  }

  Pokemon.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'],
        tipos = map['tipos'],
        urlImagem = map['urlImagem'],
        baseExperiencia = map['experiencia'],
        habilidades = map['habilidades'],
        altura = (map['altura'] as num).toDouble();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'tipos': tipos,
      'urlImagem': urlImagem,
      'experiencia': baseExperiencia,
      'habilidades': habilidades,
      'altura': altura,
    };
  }

  @override
  String toString() {
    return 'Pokemon(id: $id, nome: $nome, tipos: $tipos, urlImagem: $urlImagem, baseExperiencia: $baseExperiencia, habilidades: $habilidades, altura: $altura)';
  }
}
