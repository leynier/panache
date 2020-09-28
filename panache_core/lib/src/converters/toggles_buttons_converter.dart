import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String toggleButtonsThemeToCode(
  ToggleButtonsThemeData theme,
) {
  return '''
  ToggleButtonsThemeData(
    color: ${colorToCode(theme.color)},
    borderWidth: ${theme.borderWidth},
    borderColor: ${colorToCode(theme.borderColor)},
    disabledBorderColor: ${colorToCode(theme.disabledBorderColor)},
    disabledColor: ${colorToCode(theme.disabledColor)},
    fillColor: ${colorToCode(theme.fillColor)},
    focusColor: ${colorToCode(theme.focusColor)},
    highlightColor: ${colorToCode(theme.highlightColor)},
    hoverColor: ${colorToCode(theme.hoverColor)},
    selectedBorderColor: ${colorToCode(theme.selectedBorderColor)},
    selectedColor: ${colorToCode(theme.selectedColor)},
    splashColor: ${colorToCode(theme.splashColor)},
    textStyle: ${textStyleToCode(theme.textStyle)},
    )''';
}

Map<String, dynamic> toggleButtonsThemeToMap(
  ToggleButtonsThemeData theme,
) {
  return <String, dynamic>{
    'color': theme.color?.value,
    'borderWidth': theme.borderWidth,
    'borderColor': theme.borderColor?.value,
    'disabledBorderColor': theme.disabledBorderColor?.value,
    'disabledColor': theme.disabledColor?.value,
    'fillColor': theme.fillColor?.value,
    'focusColor': theme.focusColor?.value,
    'highlightColor': theme.highlightColor?.value,
    'hoverColor': theme.hoverColor?.value,
    'selectedBorderColor': theme.selectedBorderColor?.value,
    'selectedColor': theme.selectedColor?.value,
    'splashColor': theme.splashColor?.value,
    'textStyle': textStyleToMap(theme.textStyle),
  };
}

ToggleButtonsThemeData toggleButtonsThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return ToggleButtonsThemeData(
    color: getColorFromMap(data['color']),
    borderWidth: data['borderWidth'],
    borderColor: getColorFromMap(data['borderColor']),
    disabledBorderColor: getColorFromMap(data['disabledBorderColor']),
    disabledColor: getColorFromMap(data['disabledColor']),
    fillColor: getColorFromMap(data['fillColor']),
    focusColor: getColorFromMap(data['focusColor']),
    highlightColor: getColorFromMap(data['highlightColor']),
    hoverColor: getColorFromMap(data['hoverColor']),
    selectedBorderColor: getColorFromMap(data['selectedBorderColor']),
    selectedColor: getColorFromMap(data['selectedColor']),
    splashColor: getColorFromMap(data['splashColor']),
    textStyle: textStyleFromMap(data['textStyle']),
  );
}

/// Tester si l'iconThemeDate est null
bool toggleButtonsThemeDataIsNull(ToggleButtonsThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }
  objectIsNull = theme.borderColor == null &&
      theme.borderRadius == null &&
      theme.borderWidth == null &&
      theme.color == null &&
      theme.constraints == null &&
      theme.disabledBorderColor == null &&
      theme.disabledColor == null &&
      theme.fillColor == null &&
      theme.focusColor == null &&
      theme.highlightColor == null &&
      theme.hoverColor == null &&
      theme.selectedBorderColor == null &&
      theme.selectedBorderColor == null &&
      theme.selectedColor == null &&
      theme.splashColor == null &&
      textStyleIsNull(theme.textStyle);
  return objectIsNull;
}
