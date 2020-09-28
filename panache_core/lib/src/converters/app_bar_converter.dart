import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_core/src/converters/converter_utils.dart';
import 'package:panache_core/src/converters/icon_theme_converter.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

/// Tester s'il faut générer l'appBarTheme
bool appBarThemeIsNull(AppBarTheme appBarTheme) {
  bool objectIsNull = false;
  if (appBarTheme == null) {
    return true;
  }

  objectIsNull = appBarTheme.centerTitle == null &&
      appBarTheme.brightness == null &&
      appBarTheme.color == null &&
      appBarTheme.elevation == null &&
      appBarTheme.shadowColor == null;

  if (objectIsNull == true) {
    objectIsNull = iconThemeDataIsNull(appBarTheme?.iconTheme) &&
        iconThemeDataIsNull(appBarTheme?.actionsIconTheme);
  }
  if (objectIsNull == true) {
    objectIsNull = textThemeIsNull(appBarTheme.textTheme);
  }
  return objectIsNull;
}

String appBarThemeToCode(AppBarTheme tabBarTheme) {
  //final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  //final unselectedColor = tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return '''
  AppBarTheme(
      brightness: ${tabBarTheme?.brightness},
      centerTitle: ${tabBarTheme?.centerTitle},
      color: ${colorToCode(tabBarTheme?.color)},
      elevation: ${tabBarTheme?.elevation},
      iconTheme: ${iconThemeToCode(tabBarTheme?.iconTheme)},
      actionsIconTheme: ${iconThemeToCode(tabBarTheme?.actionsIconTheme)},
      shadowColor: ${colorToCode(tabBarTheme?.shadowColor)},
      textTheme: ${textThemeToCode(tabBarTheme?.textTheme)},
  )''';
}

Map<String, dynamic> appBarThemeToMap(AppBarTheme tabBarTheme) {
  //final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  //final unselectedColor =       tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return {
    'actionsIconTheme': iconThemeToMap(tabBarTheme.actionsIconTheme),
    'brightness': brightnessIndex(tabBarTheme.brightness),
    'centerTitle': tabBarTheme.centerTitle,
    'color': tabBarTheme.color?.value,
    'elevation': tabBarTheme.elevation,
    'iconTheme': iconThemeToMap(tabBarTheme.iconTheme),
    'shadowColor': tabBarTheme.shadowColor?.value,
    'textTheme': textThemeToMap(tabBarTheme.textTheme),
  };
}

AppBarTheme appBarThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return AppBarTheme(
    brightness: Brightness.values[max(0, data['brightness'])],
    centerTitle: data['centerTitle'],
    color: getColorFromMap(data['color']),
    elevation: data['elevation'],
    iconTheme: iconThemeFromMap(data['iconTheme']),
    actionsIconTheme: iconThemeFromMap(data['actionsIconTheme']),
    shadowColor: getColorFromMap(data['shadowColor']),
    textTheme: textThemeFromMap(data['textTheme']),
  );
}
