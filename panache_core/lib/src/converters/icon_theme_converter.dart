import 'package:flutter/material.dart';

import 'converter_utils.dart';

/// Tester si l'iconThemeDate est null
bool iconThemeDataIsNull(IconThemeData iconTheme) {
  bool objectIsNull = false;
  if (iconTheme == null) {
    return true;
  }
  objectIsNull = iconTheme?.isConcrete ?? true;
  return objectIsNull;
}

String iconThemeToCode(IconThemeData theme) {
  IconThemeData iconTheme = const IconThemeData.fallback().merge(theme);
  return '''
  IconThemeData(
      color: ${colorToCode(iconTheme.color)},
      opacity: ${iconTheme.opacity},
      size: ${iconTheme.size},
    )''';
}

Map<String, dynamic> iconThemeToMap(IconThemeData theme) {
  IconThemeData iconTheme = const IconThemeData.fallback().merge(theme);
  return <String, dynamic>{
    'color': iconTheme.color?.value,
    'opacity': iconTheme.opacity,
    'size': iconTheme.size,
  };
}

IconThemeData iconThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return IconThemeData(
    color: getColorFromMap(data['color']),
    opacity: data['opacity'] ?? 1,
    size: data['size'] ?? 12,
  );
}
