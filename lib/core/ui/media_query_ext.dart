import 'package:draftea_pokedex/core/ui/breakpoints.dart';
import 'package:flutter/material.dart';

extension MediaQueryExt on BuildContext {
  bool get isTabletUp => MediaQuery.of(this).size.width >= Breakpoints.tablet;
}
