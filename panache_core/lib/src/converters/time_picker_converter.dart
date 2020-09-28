import 'package:flutter/material.dart';
import 'package:panache_core/src/converters/input_theme_converter.dart';
import 'package:panache_core/src/converters/text_theme_converters.dart';

import 'converter_utils.dart';

String timePickerThemeToCode(TimePickerThemeData theme, Color hintColor,
    TextStyle bodyStyle, Brightness brightness) {
  return '''
  TimePickerThemeData(
    color: ${colorToCode(theme.backgroundColor)},
    dayPeriodColor: ${colorToCode(theme.dayPeriodColor)},
    dayPeriodTextColor: ${colorToCode(theme.dayPeriodTextColor)},
    dialBackgroundColor: ${colorToCode(theme.dialBackgroundColor)},
    dialHandColor: ${colorToCode(theme.dialHandColor)},
    dialTextColor: ${colorToCode(theme.dialTextColor)},
    entryModeIconColor: ${colorToCode(theme.entryModeIconColor)},
    hovehourMinuteColorrColor: ${colorToCode(theme.hourMinuteColor)},
    hourMinuteTextColor: ${colorToCode(theme.hourMinuteTextColor)},
    shape: ${shapeToCode(theme.shape)} ,
    hourMinuteShape: ${shapeToCode(theme.hourMinuteShape)} ,
    hourMinuteTextStyle: ${textStyleToCode(theme.hourMinuteTextStyle)},
    helpTextStyle: ${textStyleToCode(theme.helpTextStyle)},
    dayPeriodTextStyle: ${textStyleToCode(theme.dayPeriodTextStyle)},
    inputDecorationTheme: ${inputDecorationThemeToCode(theme.inputDecorationTheme, hintColor, bodyStyle, brightness)},
    )''';
}

Map<String, dynamic> timePickerThemeToMap(TimePickerThemeData theme,
    Color hintColor, TextStyle bodyStyle, Brightness brightness) {
  return <String, dynamic>{
    'backgroundColor': theme.backgroundColor?.value,
    'dayPeriodColor': theme.dayPeriodColor?.value,
    'dayPeriodTextColor': theme.dayPeriodTextColor?.value,
    'dialBackgroundColor': theme.dialBackgroundColor?.value,
    'dialHandColor': theme.dialHandColor?.value,
    'dialTextColor': theme.dialTextColor?.value,
    'entryModeIconColor': theme.entryModeIconColor?.value,
    'hourMinuteColor': theme.hourMinuteColor?.value,
    'hourMinuteTextColor': theme.hourMinuteTextColor?.value,
    'shape': shapeToMap(theme.shape),
    'hourMinuteShape': shapeToMap(theme.hourMinuteShape),
    'hourMinuteTextStyle': textStyleToMap(theme.hourMinuteTextStyle),
    'helpTextStyle': textStyleToMap(theme.helpTextStyle),
    'dayPeriodTextStyle': textStyleToMap(theme.dayPeriodTextStyle),
    'inputDecorationTheme': inputDecorationThemeToMap(
        theme.inputDecorationTheme, hintColor, bodyStyle, brightness)
  };
}

TimePickerThemeData timePickerThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }
  return TimePickerThemeData(
      backgroundColor: getColorFromMap(data['backgroundColor']),
      dayPeriodColor: getColorFromMap(data['dayPeriodColor']),
      dayPeriodTextColor: getColorFromMap(data['dayPeriodTextColor']),
      dialBackgroundColor: getColorFromMap(data['dialBackgroundColor']),
      dialHandColor: getColorFromMap(data['dialHandColor']),
      dialTextColor: getColorFromMap(data['dialTextColor']),
      entryModeIconColor: getColorFromMap(data['entryModeIconColor']),
      hourMinuteColor: getColorFromMap(data['hourMinuteColor']),
      hourMinuteTextColor: getColorFromMap(data['hourMinuteTextColor']),
      shape: shapeFromMap(data['shape']),
      hourMinuteShape: shapeFromMap(data['hourMinuteShape']),
      hourMinuteTextStyle: textStyleFromMap(data['hourMinuteTextStyle']),
      helpTextStyle: textStyleFromMap(data['helpTextStyle']),
      dayPeriodTextStyle: textStyleFromMap(data['dayPeriodTextStyle']),
      inputDecorationTheme:
          inputDecorationThemeFromMap(data['inputDecorationTheme']));
}

/// Tester si l'iconThemeDate est null
bool timePickerThemeDataIsNull(TimePickerThemeData theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }
  objectIsNull = theme.backgroundColor == null &&
      theme.dayPeriodColor == null &&
      theme.dayPeriodTextColor == null &&
      theme.dialBackgroundColor == null &&
      theme.dialHandColor == null &&
      theme.dialTextColor == null &&
      theme.entryModeIconColor == null &&
      theme.hourMinuteColor == null &&
      theme.hourMinuteTextColor == null &&
      theme.shape == null &&
      theme.hourMinuteShape == null &&
      textStyleIsNull(theme.hourMinuteTextStyle) &&
      textStyleIsNull(theme.helpTextStyle) &&
      textStyleIsNull(theme.dayPeriodTextStyle) &&
      inputDecorationThemeIsNull(theme.inputDecorationTheme);
  return objectIsNull;
}
