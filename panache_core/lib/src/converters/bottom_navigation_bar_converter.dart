import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/converter_utils.dart';
import 'package:panache_core/src/converters/icon_theme_converter.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

/// Tester s'il faut générer l'appBarTheme
bool bottomNavigationBarThemeIsNull(BottomNavigationBarThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.showSelectedLabels == null &&
      theme.backgroundColor == null &&
      theme.elevation == null &&
      iconThemeDataIsNull(theme.selectedIconTheme) &&
      theme.selectedItemColor == null &&
      textStyleIsNull(theme.selectedLabelStyle) &&
      theme.showSelectedLabels == null &&
      theme.showSelectedLabels == null &&
      theme.showUnselectedLabels == null &&
      theme.type == null &&
      theme.unselectedItemColor == null &&
      iconThemeDataIsNull(theme.unselectedIconTheme) &&
      textStyleIsNull(theme.unselectedLabelStyle);

  return objectIsNull;
}

String bottomNavigationBarThemeToCode(BottomNavigationBarThemeData theme) {
  //final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  //final unselectedColor = tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return '''
  BottomNavigationBarThemeData(
    backgroundColor: ${colorToCode(theme.backgroundColor)},
    selectedIconTheme: ${iconThemeToCode(theme.selectedIconTheme)},
    selectedItemColor: ${colorToCode(theme.selectedItemColor)},
    selectedLabelStyle: ${textStyleToCode(theme.selectedLabelStyle)},
    showSelectedLabels: ${theme.showSelectedLabels},
    showUnselectedLabels: ${theme.showUnselectedLabels},
    type: ${typeToCode(theme.type)},
    unselectedIconTheme: ${iconThemeToCode(theme.unselectedIconTheme)},
    unselectedItemColor: ${colorToCode(theme.unselectedItemColor)},
    unselectedLabelStyle: ${textStyleToCode(theme.unselectedLabelStyle)},
    elevation: ${theme.elevation},

  )''';
}

Map<String, dynamic> bottomNavigationBarThemeToMap(
    BottomNavigationBarThemeData theme) {
  //final selectedColor = tabBarTheme.labelColor ?? defaultLabelColor;
  //final unselectedColor =       tabBarTheme.unselectedLabelColor ?? selectedColor.withAlpha(0xB2);
  return {
    'backgroundColor': theme.backgroundColor?.value,
    'selectedIconTheme': iconThemeToMap(theme.selectedIconTheme),
    'selectedItemColor': theme.selectedItemColor?.value,
    'selectedLabelStyle': textStyleToMap(theme.selectedLabelStyle),
    'showSelectedLabels': theme.showSelectedLabels,
    'showUnselectedLabels': theme.showUnselectedLabels,
    'type': BottomNavigationBarType.values.indexOf(theme.type),
    'unselectedIconTheme': iconThemeToMap(theme.unselectedIconTheme),
    'unselectedItemColor': theme.unselectedItemColor?.value,
    'unselectedLabelStyle': textStyleToMap(theme.unselectedLabelStyle),
    'elevation': theme.elevation,
  };
}

BottomNavigationBarThemeData bottomNavigationBarThemeFromMap(
    Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return BottomNavigationBarThemeData(
    backgroundColor: getColorFromMap(data['backgroundColor']),
    selectedIconTheme: iconThemeFromMap(data['selectedIconTheme']),
    selectedItemColor: getColorFromMap(data['selectedItemColor']),
    selectedLabelStyle: textStyleFromMap(data['selectedLabelStyle']),
    showSelectedLabels: data['showSelectedLabels'],
    showUnselectedLabels: data['showUnselectedLabels'],
    type: typeFromMap(data['type']),
    unselectedIconTheme: iconThemeFromMap(data['unselectedIconTheme']),
    unselectedItemColor: getColorFromMap(data['unselectedItemColor']),
    unselectedLabelStyle: textStyleFromMap(data['unselectedLabelStyle']),
    elevation: data['elevation'],
  );
}

BottomNavigationBarType typeFromMap(Map<String, dynamic> data) {
  BottomNavigationBarType value;
  if (data['type'] == BottomNavigationBarType.fixed) {
    value = BottomNavigationBarType.fixed;
  }
  if (data['type'] == BottomNavigationBarType.shifting) {
    value = BottomNavigationBarType.shifting;
  }

  return value;
}

String typeToCode(BottomNavigationBarType type) {
  String value;
  if (type == BottomNavigationBarType.fixed) {
    value = 'BottomNavigationBarType.fixed';
  } else if (type == BottomNavigationBarType.shifting) {
    value = 'BottomNavigationBarType.shifting';
  }
  return value;
}
