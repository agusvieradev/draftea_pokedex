import 'package:draftea_pokedex/app/router.dart';
import 'package:flutter/material.dart';

class DrafteaPokedex extends StatelessWidget {
  const DrafteaPokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokedex',
      routerConfig: pokedexRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
