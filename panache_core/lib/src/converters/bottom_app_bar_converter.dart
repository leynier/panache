import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/converter_utils.dart';

/// Tester s'il faut générer l'appBarTheme
bool bottomAppBarThemeIsNull(BottomAppBarTheme appBarTheme) {
  bool objectIsNull = false;
  if (appBarTheme == null) {
    return true;
  }

  objectIsNull = appBarTheme.color == null &&
      appBarTheme.elevation == null &&
      appBarTheme.shape == null;
  return objectIsNull;
}

String bottomAppBarThemeToCode(BottomAppBarTheme tabBarTheme) {
  //final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  //final unselectedColor = tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return '''
  BottomAppBarTheme(
      color: ${colorToCode(tabBarTheme?.color)},
      elevation: ${tabBarTheme?.elevation},

  )''';
}

Map<String, dynamic> bottomAppBarThemeToMap(BottomAppBarTheme theme) {
  //final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  //final unselectedColor =       tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return {
    'color': theme.color?.value,
    'elevation': theme.elevation,
    //'shape': tabBarTheme.centerTitle,
  };
}

BottomAppBarTheme bottomAppBarThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return BottomAppBarTheme(
    color: getColorFromMap(data['color']),
    elevation: data['elevation'],
    //shape: data['shape'],
  );
}
