import 'dart:math';

import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'converter_utils.dart';

///Tester si toutes les prop de TextTheme sont à null
bool textThemeIsNull(TextTheme textTheme) {
  bool objectIsNull = false;
  if (textTheme == null) {
    return true;
  }
  objectIsNull = textStyleIsNull(textTheme?.bodyText1) &&
      textStyleIsNull(textTheme?.bodyText2) &&
      textStyleIsNull(textTheme?.button) &&
      textStyleIsNull(textTheme?.caption) &&
      textStyleIsNull(textTheme?.headline1) &&
      textStyleIsNull(textTheme?.headline2) &&
      textStyleIsNull(textTheme?.headline3) &&
      textStyleIsNull(textTheme?.headline4) &&
      textStyleIsNull(textTheme?.headline5) &&
      textStyleIsNull(textTheme?.headline6) &&
      textStyleIsNull(textTheme?.overline) &&
      textStyleIsNull(textTheme?.subtitle1) &&
      textStyleIsNull(textTheme?.subtitle2);
  return objectIsNull;
}

bool identicalTextStyle(TextStyle text1, TextStyle text2) {
  return text1.inherit == text2.inherit &&
      text1.background == text2.background &&
      text1.backgroundColor == text2.backgroundColor &&
      text1.color == text2.color &&
      //textStyle.debugLabel == null &&
      text1.decoration == text2.decoration &&
      text1.decorationColor == text2.decorationColor &&
      text1.decorationStyle == text2.decorationStyle &&
      text1.decorationThickness == text2.decorationThickness &&
      text1.fontFamily == text2.fontFamily &&
      text1.fontFeatures == text2.fontFeatures &&
      text1.fontSize == text2.fontSize &&
      text1.fontStyle == text2.fontStyle &&
      text1.fontWeight == text2.fontWeight &&
      text1.foreground == text2.foreground &&
      text1.height == text2.height &&
      text1.letterSpacing == text2.letterSpacing &&
      text1.locale == text2.locale &&
      text1.shadows == text2.shadows &&
      text1.textBaseline == text2.textBaseline &&
      text1.wordSpacing == text2.wordSpacing;
}

/// tester si le textStyle est null
bool textStyleIsNull(TextStyle textStyle) {
  bool objectIsNull = false;
  if (textStyle == null) {
    return true;
  }
  if (identicalTextStyle(textStyle, createDefaultTextStyle()) == true) {
    return true;
  }

  objectIsNull = textStyle.inherit == null &&
      textStyle.background == null &&
      textStyle.backgroundColor == null &&
      textStyle.color == null &&
      //textStyle.debugLabel == null &&
      textStyle.decoration == null &&
      textStyle.decorationColor == null &&
      textStyle.decorationStyle == null &&
      textStyle.decorationThickness == null &&
      textStyle.fontFamily == null &&
      textStyle.fontFeatures == null &&
      textStyle.fontSize == null &&
      textStyle.fontStyle == null &&
      textStyle.fontWeight == null &&
      textStyle.foreground == null &&
      textStyle.height == null &&
      textStyle.letterSpacing == null &&
      textStyle.locale == null &&
      textStyle.shadows == null &&
      textStyle.textBaseline == null &&
      textStyle.wordSpacing == null;
  return objectIsNull;
}

String textThemeToCode(TextTheme textTheme) {
  if (textTheme == null) {
    return 'null';
  }
  return '''
  TextTheme(
      headline1: ${textStyleToCode(textTheme.headline1)},
      headline2: ${textStyleToCode(textTheme.headline2)},
      headline3: ${textStyleToCode(textTheme.headline3)},
      headline4: ${textStyleToCode(textTheme.headline4)},
      headline5: ${textStyleToCode(textTheme.headline5)},
      headline6: ${textStyleToCode(textTheme.headline6)},
      subtitle1: ${textStyleToCode(textTheme.subtitle1)},
      bodyText1: ${textStyleToCode(textTheme.bodyText1)},
      bodyText2: ${textStyleToCode(textTheme.bodyText2)},
      caption: ${textStyleToCode(textTheme.caption)},
      button: ${textStyleToCode(textTheme.button)},
      subtitle2: ${textStyleToCode(textTheme.subtitle2)},
      overline: ${textStyleToCode(textTheme.overline)},
    )''';
}

Map<String, dynamic> textThemeToMap(TextTheme textTheme) {
  //assert(textTheme != null, 'textTheme must be non  null');

  if (textTheme == null) {
    return null;
  }
  return <String, dynamic>{
    'headline1': textStyleToMap(textTheme.headline1),
    'headline2': textStyleToMap(textTheme.headline2),
    'headline3': textStyleToMap(textTheme.headline3),
    'headline4': textStyleToMap(textTheme.headline4),
    'headline5': textStyleToMap(textTheme.headline5),
    'headline6': textStyleToMap(textTheme.headline6),
    'subtitle1': textStyleToMap(textTheme.subtitle1),
    'bodyText1': textStyleToMap(textTheme.bodyText1),
    'bodyText2': textStyleToMap(textTheme.bodyText2),
    'caption': textStyleToMap(textTheme.caption),
    'button': textStyleToMap(textTheme.button),
    'subtitle2': textStyleToMap(textTheme.subtitle2),
    'overline': textStyleToMap(textTheme.overline),
  };
}

TextTheme textThemeFromMap(Map<String, dynamic> data) {
  if (data == null) {
    return null;
  }

  return TextTheme(
    headline1: textStyleFromMap(data['headline1']),
    headline2: textStyleFromMap(data['headline2']),
    headline3: textStyleFromMap(data['headline3']),
    headline4: textStyleFromMap(data['headline4']),
    headline5: textStyleFromMap(data['headline5']),
    headline6: textStyleFromMap(data['headline6']),
    subtitle1: textStyleFromMap(data['subtitle1']),
    bodyText1: textStyleFromMap(data['bodyText1']),
    bodyText2: textStyleFromMap(data['bodyText2']),
    caption: textStyleFromMap(data['caption']),
    button: textStyleFromMap(data['button']),
    subtitle2: textStyleFromMap(data['subtitle2']),
    overline: textStyleFromMap(data['overline']),
  );
}

String textStyleToCode(TextStyle style) {
  //assert(style != null);
  String value;
  if (style == null) {
    return 'null';
  }
  value = '''
  TextStyle(
      color: ${colorToCode(style.color)},
      fontSize: ${style.fontSize},
      fontWeight: ${style.fontWeight ?? FontWeight.normal},
      fontStyle: ${style.fontStyle ?? FontStyle.normal},
      height: ${style.height},
      letterSpacing: ${style.letterSpacing},
      wordSpacing: ${style.wordSpacing},
      decoration: ${style.decoration},
      decorationStyle: ${style.decorationStyle},
      decorationColor: ${colorToCode(style.decorationColor)},
       
      backgroundColor: ${colorToCode(style.backgroundColor)},
      textBaseline: ${style.textBaseline},
      decorationThickness: ${style.decorationThickness}
    )''';

  /* TODO
        foreground: ${style.foreground},
        background: ${style.background},
        shadows: ${style.shadows},
        locale: ${style.locale},
        textBaseline: ${style.textBaseline},
      */
  return value;
}

Map<String, dynamic> textStyleToMap(TextStyle style) {
  //assert(style != null);
  Map<String, dynamic> value;

  if (style == null) {
    return null;
  }
  value = <String, dynamic>{
    'color': style.color?.value,
    'fontSize': style.fontSize,
    'fontWeight': max(0, FontWeight.values.indexOf(style.fontWeight)),
    'fontStyle': max(0, FontStyle.values.indexOf(style.fontStyle)),
    'height': style.height,
    'letterSpacing': style.letterSpacing,
    'wordSpacing': style.wordSpacing,
    'decoration': style.decoration?.toString(),
    'decorationColor': style.decorationColor?.value,
    'decorationStyle':
        TextDecorationStyle.values.indexOf(style.decorationStyle),
    'backgroundColor': style.backgroundColor?.value,
    'textBaseline': TextBaseline.values.indexOf(style.textBaseline),
    'decorationThickness': style.decorationThickness
    /* TODO
    
    'locale': style.locale,
    'foreground': style.foreground,
    'background': style.background,
    'shadows': style.shadows,
    */
  };
  return value;
}

TextStyle textStyleFromMap(Map<String, dynamic> data) {
  //assert(data != null);
  TextStyle value;
  if (data == null) {
    return null;
  }
  value = TextStyle(
    color: getColorFromMap(data['color']),
    fontSize: data['fontSize'],
    fontWeight: FontWeight.values[max(0, data['fontWeight'] ?? -1)],
    fontStyle: FontStyle.values[max(data['fontStyle'] ?? -1, 0)],
    height: data['height'],
    letterSpacing: data['letterSpacing'],
    wordSpacing: data['wordSpacing'],
    decoration: decorationFromMap(data['decoration']),
    decorationColor: getColorFromMap(data['decorationColor']),
    decorationStyle:
        TextDecorationStyle.values[max(0, data['decorationStyle'] ?? -1)],
    backgroundColor: getColorFromMap(data['backgroundColor']),
    decorationThickness: data['decorationThickness'],
    textBaseline: TextBaseline.values[max(0, data['textBaseline'] ?? -1)],
  );
  return value;
}
