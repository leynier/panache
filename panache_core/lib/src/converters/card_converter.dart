import 'package:flutter/material.dart';

import 'converter_utils.dart';

String cardThemeToCode(
  CardTheme theme,
) {
  return '''
  CardTheme(
      color: ${colorToCode(theme.color)},
      shadowColor: ${colorToCode(theme.shadowColor)},
      elevation: ${theme.elevation},
      shape: ${shapeToCode(theme.shape)} ,
    )''';
}

Map<String, dynamic> cardThemeToMap(
  CardTheme theme,
) {
  return <String, dynamic>{
    'color': theme.color?.value,
    'shadowColor': theme.shadowColor?.value,
    'elevation': theme.elevation,
    'shape': shapeToMap(theme.shape),
  };
}

CardTheme cardThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return CardTheme(
    color: getColorFromMap(data['color']),
    shadowColor: getColorFromMap(data['shadowColor']),
    elevation: data['elevation'],
    shape: shapeFromMap(data['shape']),
  );
}

/// Tester si l'iconThemeDate est null
bool cardThemeDataIsNull(CardTheme theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.clipBehavior == null &&
      theme.color == null &&
      theme.elevation == null &&
      theme.margin == null &&
      theme.shadowColor == null &&
      theme.shape == null;
  return objectIsNull;
}
