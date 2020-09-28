import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/converter_utils.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

String colorSchemeThemeToCode(
  ColorScheme theme,
) {
  return '''
    ${colorSchemeToCode(theme)},
  ''';
}

Map<String, dynamic> colorSchemeThemeToMap(ColorScheme theme) {
  return colorSchemeToMap(theme);
}

TooltipThemeData colorSchemeThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return colorSchemeThemeFromMap(data);
}

/// Tester si l'iconThemeDate est null
bool colorSchemeThemeDataIsNull(ColorScheme theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.background == null &&
      theme.brightness == null &&
      theme.error == null &&
      theme.onBackground == null &&
      theme.onError == null &&
      theme.onPrimary == null &&
      theme.onSecondary == null &&
      theme.onSurface == null &&
      theme.primary == null &&
      theme.primaryVariant == null &&
      theme.secondary == null &&
      theme.secondaryVariant == null &&
      theme.surface == null;

  return objectIsNull;
}
