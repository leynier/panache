import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String popupMenuThemeToCode(
  PopupMenuThemeData theme,
) {
  return '''
  PopupMenuThemeData(
      color: ${colorToCode(theme.color)},
      textStyle: ${textStyleToCode(theme.textStyle)},
      elevation: ${theme.elevation},
      shape: ${shapeToCode(theme.shape)} ,
    )''';
}

Map<String, dynamic> popupMenuThemeToMap(
  PopupMenuThemeData theme,
) {
  return <String, dynamic>{
    'color': theme.color?.value,
    'textStyle': textStyleToMap(theme.textStyle),
    'elevation': theme.elevation,
    'shape': shapeToMap(theme.shape),
  };
}

PopupMenuThemeData popupMenuThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return PopupMenuThemeData(
    color: getColorFromMap(data['color']),
    textStyle: textStyleFromMap(data['textStyle']),
    elevation: data['elevation'],
    shape: shapeFromMap(data['shape']),
  );
}

/// Tester si l'iconThemeDate est null
bool popupMenuThemeDataIsNull(PopupMenuThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.color == null &&
      theme.elevation == null &&
      theme.shape == null &&
      textStyleIsNull(theme.textStyle);
  return objectIsNull;
}
