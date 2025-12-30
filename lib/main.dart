import 'package:draftea_pokedex/app/app_dependencies.dart';
import 'package:draftea_pokedex/app/draftea_pokedex.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupObservers();
  await initCore();
  runApp(const DrafteaPokedex());
}
