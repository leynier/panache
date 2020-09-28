import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String snackBarThemeToCode(
  SnackBarThemeData theme,
) {
  return '''
  SnackBarThemeData(
      actionTextColor: ${colorToCode(theme.actionTextColor)},
      backgroundColor: ${colorToCode(theme.backgroundColor)},
      disabledActionTextColor: ${colorToCode(theme.disabledActionTextColor)},
      elevation: ${theme.elevation},
      shape: ${shapeToCode(theme.shape)} ,
      contentTextStyle: ${textStyleToCode(theme.contentTextStyle)}
    )''';
}

Map<String, dynamic> snackBarThemeToMap(
  SnackBarThemeData theme,
) {
  return <String, dynamic>{
    'actionTextColor': theme.actionTextColor?.value,
    'backgroundColor': theme.backgroundColor?.value,
    'disabledActionTextColor': theme.disabledActionTextColor?.value,
    'elevation': theme.elevation,
    'shape': shapeToMap(theme.shape),
    'contentTextStyle': textStyleToMap(theme.contentTextStyle),
  };
}

SnackBarThemeData snackBarhemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return SnackBarThemeData(
    actionTextColor: getColorFromMap(data['actionTextColor']),
    backgroundColor: getColorFromMap(data['backgroundColor']),
    disabledActionTextColor: getColorFromMap(data['disabledActionTextColor']),
    elevation: data['elevation'],
    shape: shapeFromMap(data['shape']),
    contentTextStyle: textStyleFromMap(data['contentTextStyle']),
  );
}

/// Tester si l'iconThemeDate est null
bool snackBarThemeDataIsNull(SnackBarThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }

  objectIsNull = theme.actionTextColor == null &&
      theme.backgroundColor == null &&
      theme.behavior == null &&
      theme.disabledActionTextColor == null &&
      theme.elevation == null &&
      theme.shape == null &&
      textStyleIsNull(theme.contentTextStyle);
  return objectIsNull;
}
