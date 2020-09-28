import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

String tooltipThemeToCode(
  TooltipThemeData theme,
) {
  return '''
  TooltipThemeData(
    excludeFromSemantics: ${theme.excludeFromSemantics},
    height: ${theme.height},
    preferBelow: ${theme.preferBelow},
    textStyle: ${textStyleToCode(theme.textStyle)},
    verticalOffset: ${theme.verticalOffset},
    )''';
}

Map<String, dynamic> tooltipThemeToMap(TooltipThemeData theme) {
  return <String, dynamic>{
    'excludeFromSemantics': theme.excludeFromSemantics,
    'height': theme.height,
    'preferBelow': theme.preferBelow,
    'textStyle': textStyleToMap(theme.textStyle),
    'verticalOffset': theme.verticalOffset,
  };
}

TooltipThemeData tooltipThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return TooltipThemeData(
      excludeFromSemantics: data['excludeFromSemantics'],
      height: data['height'],
      preferBelow: data['preferBelow'],
      textStyle: textStyleFromMap(data['textStyle']),
      verticalOffset: data['verticalOffset']);
}

/// Tester si l'iconThemeDate est null
bool tooltipThemeDataIsNull(TooltipThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.excludeFromSemantics == null &&
      theme.decoration == null &&
      theme.height == null &&
      theme.margin == null &&
      theme.padding == null &&
      theme.preferBelow == null &&
      theme.showDuration == null &&
      theme.verticalOffset == null &&
      theme.waitDuration == null &&
      textStyleIsNull(theme.textStyle);

  return objectIsNull;
}
