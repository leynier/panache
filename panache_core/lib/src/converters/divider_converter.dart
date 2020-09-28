import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String dividerThemeToCode(
  DividerThemeData theme,
) {
  return '''
  DividerThemeData(
      color: ${colorToCode(theme.color)},
      indent: ${theme.indent},
      endIndent: ${theme.endIndent},
      space: ${theme.space},
      thickness: ${theme.thickness},
    )''';
}

Map<String, dynamic> dividerThemeToMap(
  DividerThemeData theme,
) {
  return <String, dynamic>{
    'color': theme.color?.value,
    'indent': theme.indent,
    'endIndent': theme.endIndent,
    'space': theme.space,
    'thickness': theme.thickness,
  };
}

DividerThemeData dividerThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return DividerThemeData(
    color: getColorFromMap(data['color']),
    indent: data['contentTextStyle'],
    endIndent: data['endIndent'],
    space: data['space'],
    thickness: data['thickness'],
  );
}

/// Tester si l'iconThemeDate est null
bool dividerThemeDataIsNull(DividerThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.color == null &&
      theme.indent == null &&
      theme.endIndent == null &&
      theme.space == null &&
      theme.thickness == null;
  return objectIsNull;
}
