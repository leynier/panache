import 'dart:math';

import 'package:flutter/material.dart';

import 'converter_utils.dart';
import 'text_theme_converters.dart';

String inputDecorationThemeToCode(InputDecorationTheme inputTheme,
    Color hintColor, TextStyle bodyStyle, Brightness brightness) {
  TextStyle defaultHintStyle = TextStyle(color: hintColor).merge(bodyStyle);
  InputBorder defaultBorder =
      inputTheme?.border ?? const UnderlineInputBorder();

  if (inputTheme == null) {
    return 'null';
  }

  return '''
  InputDecorationTheme(
    labelStyle: ${textStyleToCode(inputTheme.labelStyle ?? defaultHintStyle)},
    helperStyle: ${textStyleToCode(inputTheme.helperStyle ?? defaultHintStyle)},
    hintStyle: ${textStyleToCode(inputTheme.hintStyle ?? defaultHintStyle)},
    errorStyle: ${textStyleToCode(inputTheme.errorStyle ?? defaultHintStyle)},
    errorMaxLines: ${inputTheme.errorMaxLines},
    isDense: ${inputTheme.isDense},
    contentPadding: ${paddingToCode(
    inputTheme.contentPadding ?? getDefaultContentPadding(inputTheme),
  )},
    isCollapsed : ${inputTheme.isCollapsed},
    prefixStyle: ${textStyleToCode(inputTheme.prefixStyle ?? defaultHintStyle)},
    suffixStyle: ${textStyleToCode(inputTheme.suffixStyle ?? defaultHintStyle)},
    counterStyle: ${textStyleToCode(
    inputTheme.counterStyle ?? defaultHintStyle,
  )},
    filled: ${inputTheme.filled},
    fillColor: ${colorToCode(_getFillColor(inputTheme, brightness))},
    focusColor: ${inputTheme.focusColor},
    hoverColor: ${inputTheme.hoverColor},
    alignLabelWithHint : ${inputTheme.alignLabelWithHint},
    floatingLabelBehavior: ${inputTheme.floatingLabelBehavior},
    errorBorder: ${inputBorderToCode(inputTheme.errorBorder ?? defaultBorder)},
    focusedBorder: ${inputBorderToCode(
    inputTheme.focusedBorder ?? defaultBorder,
  )},
    focusedErrorBorder: ${inputBorderToCode(
    inputTheme.focusedErrorBorder ?? defaultBorder,
  )},
    disabledBorder: ${inputBorderToCode(
    inputTheme.disabledBorder ?? defaultBorder,
  )},
    enabledBorder: ${inputBorderToCode(
    inputTheme.enabledBorder ?? defaultBorder,
  )},
    border: ${inputBorderToCode(defaultBorder)},
  )''';
}

Color _getFillColor(InputDecorationTheme theme, Brightness brightness) {
  if (theme.filled != true) {
    return Colors.transparent;
  }
  if (theme.fillColor != null) {
    return theme.fillColor;
  }

  // dark theme: 10% white (enabled), 5% white (disabled)
  // light theme: 4% black (enabled), 2% black (disabled)
  const Color darkEnabled = Color(0x1AFFFFFF);
  const Color lightEnabled = Color(0x0A000000);

  switch (brightness) {
    case Brightness.dark:
      return darkEnabled;
    case Brightness.light:
      return lightEnabled;
  }
  return lightEnabled;
}

String inputBorderToCode(InputBorder border) {
  if (border is UnderlineInputBorder) {
    return '''
    UnderlineInputBorder(
      borderSide: ${borderSideToCode(border.borderSide)},
      borderRadius: BorderRadius.all(${border.borderRadius.topLeft}),
    )''';
  }
  if (border is OutlineInputBorder) {
    return '''
    OutlineInputBorder(
      borderSide: ${borderSideToCode(border.borderSide)},
      borderRadius: BorderRadius.all(${border.borderRadius.topLeft}),
      gapPadding: ${border.gapPadding}
    )''';
  }
  if (border is InputBorder || border == null) {
    return '''InputBorder.none''';
  }

  throw Exception('Unknown InputBorder $border');
}

Map<String, dynamic> inputDecorationThemeToMap(
  InputDecorationTheme inputTheme,
  Color hintColor,
  TextStyle bodyStyle,
  Brightness brightness,
) {
  if (inputTheme == null) {
    return null;
  }

  TextStyle defaultHintStyle = TextStyle(color: hintColor).merge(bodyStyle);
  InputBorder defaultBorder = inputTheme.border ?? const UnderlineInputBorder();
  return <String, dynamic>{
    'labelStyle': textStyleToMap(inputTheme.labelStyle ?? defaultHintStyle),
    'helperStyle': textStyleToMap(inputTheme.helperStyle ?? defaultHintStyle),
    'hintStyle': textStyleToMap(inputTheme.hintStyle ?? defaultHintStyle),
    'errorStyle': textStyleToMap(inputTheme.errorStyle ?? defaultHintStyle),
    'prefixStyle': textStyleToMap(inputTheme.prefixStyle ?? defaultHintStyle),
    'suffixStyle': textStyleToMap(inputTheme.suffixStyle ?? defaultHintStyle),
    'counterStyle': textStyleToMap(inputTheme.counterStyle ?? defaultHintStyle),
    'errorMaxLines': inputTheme.errorMaxLines,
    'focusColor': inputTheme.focusColor?.value,
    'hoverColor': inputTheme.hoverColor?.value,
    'alignLabelWithHint': inputTheme.alignLabelWithHint,
    'floatingLabelBehavior':
        FloatingLabelBehavior.values.indexOf(inputTheme.floatingLabelBehavior),
    'isDense': inputTheme.isDense,
    'contentPadding': paddingToMap(
        inputTheme.contentPadding ?? getDefaultContentPadding(inputTheme)),
    'isCollapsed': inputTheme.isCollapsed,
    'filled': inputTheme.filled,
    'fillColor': _getFillColor(inputTheme, brightness).value,
    'errorBorder': inputBorderToMap(inputTheme.errorBorder ?? defaultBorder),
    'focusedBorder':
        inputBorderToMap(inputTheme.focusedBorder ?? defaultBorder),
    'focusedErrorBorder':
        inputBorderToMap(inputTheme.focusedErrorBorder ?? defaultBorder),
    'disabledBorder':
        inputBorderToMap(inputTheme.disabledBorder ?? defaultBorder),
    'enabledBorder':
        inputBorderToMap(inputTheme.enabledBorder ?? defaultBorder),
    'border': inputBorderToMap(defaultBorder)
  };
}

Map<String, dynamic> inputBorderToMap(InputBorder border) {
  String type = getInputBorderType(border);

  if (border is UnderlineInputBorder) {
    return <String, dynamic>{
      'type': type,
      'radius':
          borderRadiusToMap(/*border.borderRadius ?? */ BorderRadius.zero),
      'side': borderSideToMap(border.borderSide)
    };
  }

  if (border is OutlineInputBorder) {
    return <String, dynamic>{
      'type': type,
      'radius': borderRadiusToMap(border.borderRadius ?? BorderRadius.zero),
      'side': borderSideToMap(border.borderSide),
      'gapPadding': border.gapPadding
    };
  }

  if (border is InputBorder || border == null) {
    return <String, dynamic>{'type': type};
  }

  throw Exception('Unknown InputBorder $border');
}

InputDecorationTheme inputDecorationThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return InputDecorationTheme(
      labelStyle: textStyleFromMap(data['labelStyle']),
      helperStyle: textStyleFromMap(data['helperStyle']),
      hintStyle: textStyleFromMap(data['hintStyle']),
      errorStyle: textStyleFromMap(data['errorStyle']),
      errorMaxLines: data['errorMaxLines'],
      focusColor: getColorFromMap(data['focusColor']),
      hoverColor: getColorFromMap(data['hoverColor']),
      alignLabelWithHint: data['alignLabelWithHint'],
      floatingLabelBehavior:
          FloatingLabelBehavior.values[max(0, data['floatingLabelBehavior'])],
      isDense: data['isDense'],
      contentPadding: paddingFromMap(data['contentPadding']),
      isCollapsed: data['isCollapsed'],
      prefixStyle: textStyleFromMap(data['prefixStyle']),
      suffixStyle: textStyleFromMap(data['suffixStyle']),
      counterStyle: textStyleFromMap(data['counterStyle']),
      filled: data['filled'],
      fillColor: getColorFromMap(data['fillColor']),
      errorBorder: inputBorderFromMap(data['errorBorder']),
      focusedBorder: inputBorderFromMap(data['focusedBorder']),
      focusedErrorBorder: inputBorderFromMap(data['focusedErrorBorder']),
      disabledBorder: inputBorderFromMap(data['disabledBorder']),
      enabledBorder: inputBorderFromMap(data['enabledBorder']),
      border: inputBorderFromMap(data['border']));
}

InputBorder inputBorderFromMap(Map<String, dynamic> data) {
  if (data['type'] == 'UnderlineInputBorder') {
    return UnderlineInputBorder(
      borderSide: borderSideFromMap(data['side']),
    );
  }

  if (data['type'] == 'OutlineInputBorder') {
    return OutlineInputBorder(
        borderRadius: borderRadiusFromMap(data['radius']),
        borderSide: borderSideFromMap(data['side']),
        gapPadding: data['gapPadding']);
  }

  if (data['type'] == 'None') {
    return InputBorder.none;
  }

  throw Exception('Unknown InputBorder $data');
}

String getInputBorderType(InputBorder border) {
  if (border is UnderlineInputBorder) {
    return 'UnderlineInputBorder';
  }
  if (border is OutlineInputBorder) {
    return 'OutlineInputBorder';
  }
  if (border is InputBorder || border == null) {
    return 'None';
  }

  throw Exception('Unknown InputBorder type $border');
}

EdgeInsets getDefaultContentPadding(InputDecorationTheme theme) {
  EdgeInsets contentPadding;
  double floatingLabelHeight;

  if (theme.isCollapsed) {
    floatingLabelHeight = 0;
    contentPadding = theme.contentPadding ?? EdgeInsets.zero;
  } else if (getInputBorderType(theme.border) != 'OutlineInputBorder') {
    // 4.0: the vertical gap between the inline elements and the floating label.
    floatingLabelHeight = 4.0 + 0.75 * (theme.labelStyle?.fontSize ?? 14);
    if (theme.filled == true) {
      // filled == null same as filled == false
      contentPadding = theme.contentPadding ??
          (theme.isDense
              ? const EdgeInsets.fromLTRB(12, 8, 12, 8)
              : const EdgeInsets.fromLTRB(12, 12, 12, 12));
    } else {
      // Not left or right padding for underline borders that aren't filled
      // is a small concession to backwards compatibility. This eliminates
      // the most noticeable layout change introduced by #13734.
      contentPadding = theme.contentPadding ??
          (theme.isDense
              ? const EdgeInsets.fromLTRB(0, 8, 0, 8)
              : const EdgeInsets.fromLTRB(0, 12, 0, 12));
    }
  } else {
    floatingLabelHeight = 0;
    contentPadding = theme.contentPadding ??
        (theme.isDense
            ? const EdgeInsets.fromLTRB(12, 20, 12, 12)
            : const EdgeInsets.fromLTRB(12, 24, 12, 16));
  }
  return contentPadding;
}

/// Tester si l'iconThemeDate est null
bool inputDecorationThemeIsNull(InputDecorationTheme theme) {
  bool objectIsNull = false;
  if (theme == null) {
    return true;
  }
  objectIsNull = theme.alignLabelWithHint == null &&
      theme.border == null &&
      theme.contentPadding == null &&
      theme.disabledBorder == null &&
      theme.enabledBorder == null &&
      theme.errorBorder == null &&
      theme.errorMaxLines == null &&
      theme.fillColor == null &&
      theme.filled == null &&
      theme.floatingLabelBehavior == null &&
      theme.focusColor == null &&
      theme.focusedBorder == null &&
      theme.focusedErrorBorder == null &&
      theme.helperMaxLines == null &&
      theme.hoverColor == null &&
      theme.isCollapsed == null &&
      theme.isDense == null &&
      textStyleIsNull(theme.suffixStyle) &&
      textStyleIsNull(theme.counterStyle) &&
      textStyleIsNull(theme.errorStyle) &&
      textStyleIsNull(theme.helperStyle) &&
      textStyleIsNull(theme.hintStyle) &&
      textStyleIsNull(theme.labelStyle) &&
      textStyleIsNull(theme.prefixStyle);
  return objectIsNull;
}
