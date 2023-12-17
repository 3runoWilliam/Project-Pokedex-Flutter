import 'package:flutter/material.dart';

class TelaMaterialApp extends StatelessWidget {
  const TelaMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tela Material App'),
        ),
        body: const Center(
          child: Text('Conteúdo da Tela Material App'),
        ),
      ),
    );
  }
}