import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// Build default textStyle
/// Based on TextStyleControl constructor
TextStyle createDefaultTextStyle() {
  TextStyle defaultTextStyle;

  defaultTextStyle = const TextStyle(
    color: Colors.black,
    backgroundColor: Colors.transparent,
    decoration: TextDecoration.none,
    textBaseline: TextBaseline.alphabetic,
    fontWeight: FontWeight.normal,
    letterSpacing: 1,
    fontSize: 12,
    decorationStyle: TextDecorationStyle.solid,
    decorationThickness: 1,
  );

  return defaultTextStyle;
}
