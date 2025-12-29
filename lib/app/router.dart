import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final pokedexRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const Placeholder(),
    ),
  ],
);
