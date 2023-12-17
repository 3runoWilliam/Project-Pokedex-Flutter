import 'package:flutter/material.dart';

import 'package:project_pokedex_flutter/widgets/TelaHome.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Meu App',
      home: TelaHome(),
    );
  }
}
