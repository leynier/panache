import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/button_theme_converters.dart';
import 'package:panache_core/src/converters/converter_utils.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

String dialogThemeToCode(DialogTheme dialogTheme) {
  return '''
  DialogTheme(
      shape: ${shapeToCode(dialogTheme.shape ?? const RoundedRectangleBorder())},
      backgroundColor: ${colorToCode(dialogTheme.backgroundColor)},
      elevation: ${dialogTheme.elevation},
      contentTextStyle: ${textStyleToCode(dialogTheme.contentTextStyle)},
      titleTextStyle: ${textStyleToCode(dialogTheme.titleTextStyle)},
    )''';
}

Map<String, dynamic> dialogThemeToMap(DialogTheme dialogTheme) {
  return {
    'shape': shapeToMap(dialogTheme.shape ?? const RoundedRectangleBorder()),
    'backgroundColor': dialogTheme.backgroundColor?.value,
    'elevation': dialogTheme.elevation,
    'contentTextStyle': textStyleToMap(dialogTheme.contentTextStyle),
    'titleTextStyle': textStyleToMap(dialogTheme.titleTextStyle),
  };
}

DialogTheme dialogThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return DialogTheme(
    shape: shapeFromMap(data),
    backgroundColor: getColorFromMap(data['backgroundColor']),
    elevation: data['elevation'],
    contentTextStyle: textStyleFromMap(data['contentTextStyle']),
    titleTextStyle: textStyleFromMap(data['titleTextStyle']),
  );
}
