import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../controls/text_style_control.dart';

class TypographyThemePanel extends StatelessWidget {
  final TextTheme txtTheme;
  final String txtThemeRef;
  final ThemeModel model;
  final String modelParamRef;
  final Function currentThemeCopyWith;

  const TypographyThemePanel({
    @required this.txtTheme,
    @required this.txtThemeRef,
    @required this.model,
    Key key,
    this.modelParamRef,
    this.currentThemeCopyWith,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey.shade200,
        padding: kPadding,
        child: Column(
          children: _buildTextThemeEditorFields(model),
        ),
      );

  List<Widget> _buildTextThemeEditorFields(ThemeModel model) {
    TextStyle subtitle1 = txtTheme.subtitle1;
    TextStyle subtitle2 = txtTheme.subtitle2;
    TextStyle bodyText2 = txtTheme.bodyText2;
    TextStyle bodyText1 = txtTheme.bodyText1;
    TextStyle caption = txtTheme.caption;
    TextStyle overline = txtTheme.overline;
    TextStyle button = txtTheme.button;

    TextStyle headline6 = txtTheme.headline6;
    TextStyle headline5 = txtTheme.headline5;
    TextStyle headline4 = txtTheme.headline4;
    TextStyle headline3 = txtTheme.headline3;
    TextStyle headline2 = txtTheme.headline2;
    TextStyle headline1 = txtTheme.headline1;

    List<TextStyleControlData> styleNames = <TextStyleControlData>[
      TextStyleControlData(styleName: 'headline1', style: headline1),
      TextStyleControlData(styleName: 'headline2', style: headline2),
      TextStyleControlData(styleName: 'headline3', style: headline3),
      TextStyleControlData(styleName: 'headline4', style: headline4),
      TextStyleControlData(styleName: 'headline5', style: headline5),
      TextStyleControlData(styleName: 'headline6', style: headline6),
      TextStyleControlData(styleName: 'subtitle1', style: subtitle1),
      TextStyleControlData(styleName: 'subtitle2', style: subtitle2),
      TextStyleControlData(styleName: 'bodyText1', style: bodyText1),
      TextStyleControlData(styleName: 'bodyText2', style: bodyText2),
      TextStyleControlData(styleName: 'button', style: button),
      TextStyleControlData(styleName: 'caption', style: caption),
      TextStyleControlData(styleName: 'overline', style: overline),
    ];

    return styleNames.map((TextStyleControlData data) {
      return buildTextStyleControl(txtThemeRef, model, txtTheme.copyWith,
          key: null,
          label: data.styleName,
          textStyle: data.style,
          styleName: data.styleName,
          modelParamRef: modelParamRef,
          currentThemeCopyWith: currentThemeCopyWith);
    }).toList();

    /*return styleNames.map((data) {
      return TextStyleControl(
        data.styleName,
        style: data.style,
        //key: null,
        onColorChanged: (Color color) =>
            apply(data.style.copyWith(color: color), data.styleName),
        onSizeChanged: (size) {
          print(
              'TypographyThemePanel._buildTextThemeEditorFields... $size ${data.style}');
          apply(data.style.copyWith(fontSize: size), data.styleName);
        },
        onWeightChanged: (isBold) => apply(
          data.style.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          data.styleName,
        ),
        onFontStyleChanged: (isItalic) => apply(
          data.style.copyWith(
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          data.styleName,
        ),
        onLetterSpacingChanged: (double spacing) =>
            apply(data.style.copyWith(letterSpacing: spacing), data.styleName),
        onWordSpacingChanged: (double spacing) =>
            apply(data.style.copyWith(wordSpacing: spacing), data.styleName),
        onLineHeightChanged: (double lineHeight) =>
            apply(data.style.copyWith(height: lineHeight), data.styleName),
        onDecorationChanged: (TextDecoration decoration) =>
            apply(data.style.copyWith(decoration: decoration), data.styleName),
        onDecorationStyleChanged: (TextDecorationStyle decorationStyle) =>
            apply(data.style.copyWith(decorationStyle: decorationStyle),
                data.styleName),
        onDecorationColorChanged: (Color color) =>
            apply(data.style.copyWith(decorationColor: color), data.styleName),
      );
    }).toList();*/
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextTheme>('txtTheme', txtTheme));
    properties.add(StringProperty('txtThemeRef', txtThemeRef));
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty('modelParamRef', modelParamRef));
    properties.add(DiagnosticsProperty<Function>(
        'currentThemeCopyWith', currentThemeCopyWith));
  }
}

class TextStyleControlData {
  final TextStyle style;
  final String styleName;

  TextStyleControlData({this.style, this.styleName});
}
