import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';

import '../editor_utils.dart';
import 'color_selector.dart';

import 'font_size_slider.dart';
import 'slider_control.dart';
import 'switcher_control.dart';

const List<SelectionItem<TextDecorationStyle>> _textDecorationStyles =
    <SelectionItem<TextDecorationStyle>>[
  SelectionItem<TextDecorationStyle>('Solid', TextDecorationStyle.solid),
  SelectionItem<TextDecorationStyle>('Dashed', TextDecorationStyle.dashed),
  SelectionItem<TextDecorationStyle>('Dotted', TextDecorationStyle.dotted),
  SelectionItem<TextDecorationStyle>('Wavy', TextDecorationStyle.wavy),
  SelectionItem<TextDecorationStyle>('Double', TextDecorationStyle.double),
];

const List<SelectionItem<TextBaseline>> _textBaseline =
    <SelectionItem<TextBaseline>>[
  SelectionItem<TextBaseline>('Alphabetic', TextBaseline.alphabetic),
  SelectionItem<TextBaseline>('Ideographic', TextBaseline.ideographic),
];

const List<SelectionItem<TextDecoration>> _textDecorations =
    <SelectionItem<TextDecoration>>[
  SelectionItem<TextDecoration>('None', TextDecoration.none),
  SelectionItem<TextDecoration>('underline', TextDecoration.underline),
  SelectionItem<TextDecoration>('Linethrough', TextDecoration.lineThrough),
  SelectionItem<TextDecoration>('Overline', TextDecoration.overline),
];
TextStyleControl buildTextStyleControl(
  String txtThemeRef,
  ThemeModel model,
  Function currentTxtThemeCopyWith, {
  @required String key,
  @required String label,
  @required TextStyle textStyle,
  @required String styleName,
  List<dynamic> positionalArguments,
  bool useMobileLayout,
  String modelParamRef,
  //Si jamais on est sur une propriété 'complexe' tu thème, genre AppBarTheme
  Function currentThemeCopyWith,
}) {
  TextStyleControl cmp;
  cmp = TextStyleControl(
    label,
    key: key != null ? Key(key) : null,
    style: textStyle,
    useMobileLayout: useMobileLayout ?? false,
    //maxFontSize: 32,
    onColorChanged: (Color color) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(color: color),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onSizeChanged: (double size) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(fontSize: size),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onWeightChanged: (bool isBold) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onFontStyleChanged: (bool isItalic) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(
          fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onLetterSpacingChanged: (double value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(letterSpacing: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onLineHeightChanged: (double value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(height: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onWordSpacingChanged: (double value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(wordSpacing: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onDecorationChanged: (TextDecoration value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(decoration: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onDecorationStyleChanged: (TextDecorationStyle value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(decorationStyle: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onDecorationColorChanged: (Color value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(decorationColor: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onBackgroundColorChanged: (Color value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(backgroundColor: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onDecorationThicknessChanged: (double value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(decorationThickness: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
    onTextBaselineChanged: (TextBaseline value) => apply(
      txtThemeRef,
      model,
      currentTxtThemeCopyWith,
      textStyle.copyWith(textBaseline: value),
      styleName,
      positionalArguments: positionalArguments,
      modelParamRef: modelParamRef,
      currentThemeCopyWith: currentThemeCopyWith,
    ),
  );
  return cmp;
}

void apply(String txtThemeRef, ThemeModel model,
    Function currentTxtThemeCopyWith, TextStyle style, String styleName,
    {List<dynamic> positionalArguments,
    //Si jamais on est sur une propriété 'comlexe' tu thème, genre AppBarTheme
    Function currentThemeCopyWith,
    String modelParamRef}) {
  Map<Symbol, dynamic> styleArgs = <Symbol, dynamic>{};
  //On construit les données finales
  //headline1 : TextStyle(style)
  styleArgs[Symbol(styleName)] = style;

  Map<Symbol, dynamic> args = <Symbol, dynamic>{};
  //Préparation de la copie sur l'argument 'txtThemeRef' sur le 'currentTxtThemeCopyWith'
  //primaryTextTheme: textTheme.copywith(headline1 : TextStyle(style))
  args[Symbol(txtThemeRef)] =
      Function.apply(currentTxtThemeCopyWith, positionalArguments, styleArgs);

  if (modelParamRef != null) {
    //Si on a une sous référence au thème c'est qu'on doit appliquer à une sous-propriété du thème
    // Exemple, model.theme.copyWith(appBarTheme: currentThemeCopyWith.copyWith(textTheme: styleArgs))
    model.updateTheme(Function.apply(
        model.theme.copyWith, null, <Symbol, dynamic>{
      Symbol(modelParamRef): Function.apply(currentThemeCopyWith, null, args)
    }));
    /*model.updateTheme(model.theme.copyWith(
        timePickerTheme: model.theme.timePickerTheme.copyWith(
            inputDecorationTheme: model.theme.inputDecorationTheme.copyWith(
                labelStyle: TextStyle(
                    color: Colors.blue, backgroundColor: Colors.deepPurple)))));*/
  } else {
    //On applique que le thème courant
    //model.theme.copyWith(primaryTextTheme: textTheme.copywith(headline1 : TextStyle(style)))
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }
}

class TextStyleControl extends StatefulWidget {
  final String label;

  final ValueChanged<Color> onColorChanged;

  final ValueChanged<Color> onBackgroundColorChanged;

  final ValueChanged<TextBaseline> onTextBaselineChanged;

  final ValueChanged<double> onDecorationThicknessChanged;

  final ValueChanged<double> onSizeChanged;

  final ValueChanged<double> onLetterSpacingChanged;

  final ValueChanged<double> onWordSpacingChanged;

  final ValueChanged<double> onLineHeightChanged;

  // TODO select from all FontWeight values
  final ValueChanged<bool> onWeightChanged;

  final ValueChanged<bool> onFontStyleChanged;

  final ValueChanged<TextDecoration> onDecorationChanged;

  final ValueChanged<TextDecorationStyle> onDecorationStyleChanged;

  final ValueChanged<Color> onDecorationColorChanged;

  final Color color;

  final Color backgroundColor;

  final double fontSize;

  final double maxFontSize;

  final double lineHeight;

  final bool isBold;

  final bool isItalic;

  final double letterSpacing;

  final double wordSpacing;

  final double decorationThickness;

  final TextBaseline textBaseLine;

  final TextDecoration decoration;

  final TextDecorationStyle decorationStyle;

  final Color decorationColor;

  final TextStyle style;

  final bool expanded;

  final bool useMobileLayout;

  TextStyleControl(
    this.label, {
    @required this.style,
    @required this.onColorChanged,
    @required this.onSizeChanged,
    @required this.onWeightChanged,
    @required this.onFontStyleChanged,
    @required this.onLetterSpacingChanged,
    @required this.onWordSpacingChanged,
    @required this.onLineHeightChanged,
    @required this.onDecorationChanged,
    @required this.onDecorationStyleChanged,
    @required this.onDecorationColorChanged,
    @required this.onBackgroundColorChanged,
    @required this.onTextBaselineChanged,
    @required this.onDecorationThicknessChanged,
    Key key,
    this.useMobileLayout = false,
    this.expanded = false,
    this.maxFontSize = 112,
  })  : color = style?.color ?? Colors.black,
        backgroundColor = style?.backgroundColor ?? Colors.transparent,
        letterSpacing = style?.letterSpacing ?? 1,
        lineHeight = style?.height ?? 1,
        wordSpacing = style?.wordSpacing ?? 1,
        fontSize = style?.fontSize ?? 12,
        decoration = style?.decoration ?? TextDecoration.none,
        decorationStyle = style?.decorationStyle ?? TextDecorationStyle.solid,
        decorationColor = style?.decorationColor ?? style?.color,
        isBold = style?.fontWeight == FontWeight.bold,
        isItalic = style?.fontStyle == FontStyle.italic,
        textBaseLine = style?.textBaseline ?? TextBaseline.alphabetic,
        decorationThickness = style?.decorationThickness ?? 1,
        super(key: key);

  @override
  TextStyleControlState createState() {
    return TextStyleControlState();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
  }
}

class TextStyleControlState extends State<TextStyleControl> {
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    //expanded = widget.expanded;
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    List<Widget> controls = [
      getFieldsRow(<Widget>[
        ColorSelector(
          'Color',
          widget.color,
          widget.onColorChanged,
          padding: 0,
        ),
        ColorSelector(
          'BackgroundColor',
          widget.backgroundColor,
          widget.onBackgroundColorChanged,
          padding: 0,
        ),
      ]),
      getFieldsRow(<Widget>[
        //if (!kIsWeb)
        FontSizeSelector(
          widget.fontSize,
          widget.onSizeChanged,
          min: 8,
          max: widget.maxFontSize,
          vertical: true,
        ),
        SliderPropertyControl(
          widget.lineHeight,
          widget.onLineHeightChanged,
          label: 'Line height',
          min: 1,
          max: 3,
          showDivisions: false,
          vertical: true,
        ),
      ]),
      getFieldsRow(<Widget>[
        SwitcherControl(
            direction: widget.useMobileLayout ? Axis.vertical : Axis.horizontal,
            checked: widget.isBold,
            checkedLabel: 'Bold',
            onChange: widget.onWeightChanged),
        SwitcherControl(
            direction: widget.useMobileLayout ? Axis.vertical : Axis.horizontal,
            checked: widget.isItalic,
            checkedLabel: 'Italic',
            onChange: widget.onFontStyleChanged),
      ] /*, direction: Axis.vertical*/),
      getFieldsRow(<Widget>[
        SliderPropertyControl(
          widget.letterSpacing,
          widget.onLetterSpacingChanged,
          label: 'Letter spacing',
          min: -5,
          max: 5,
          showDivisions: false,
          vertical: true,
        ),
        SliderPropertyControl(
          widget.wordSpacing,
          widget.onWordSpacingChanged,
          label: 'Word spacing',
          min: -5,
          max: 5,
          showDivisions: false,
          vertical: true,
        ),
      ]),
      getFieldsRow(<Widget>[
        PanacheDropdown<SelectionItem<TextDecoration>>(
          label: 'Decoration',
          selection: widget.decoration != null
              ? _textDecorations.firstWhere(
                  (SelectionItem<TextDecoration> item) =>
                      item.value == widget.decoration)
              : _textDecorations.first,
          collection: _textDecorations,
          onValueChanged: (SelectionItem<TextDecoration> decoration) =>
              widget.onDecorationChanged(decoration.value),
        ),
        PanacheDropdown<SelectionItem<TextDecorationStyle>>(
          label: 'Decoration style',
          selection: widget.decorationStyle != null
              ? _textDecorationStyles.firstWhere(
                  (SelectionItem<TextDecorationStyle> item) =>
                      item.value == widget.decorationStyle)
              : _textDecorationStyles.first,
          collection: _textDecorationStyles,
          onValueChanged:
              (SelectionItem<TextDecorationStyle> decorationStyle) =>
                  widget.onDecorationStyleChanged(decorationStyle.value),
        ),
      ]),
      getFieldsRow(<Widget>[
        ColorSelector(
            'Decoration color',
            widget.decorationColor ?? Colors.black,
            widget.onDecorationColorChanged),
        SliderPropertyControl(
          widget.decorationThickness,
          widget.onDecorationThicknessChanged,
          label: 'decorationThickness',
          max: 3,
          showDivisions: false,
          vertical: true,
        ),
      ]),
      PanacheDropdown<SelectionItem<TextBaseline>>(
        label: 'TextBaseline',
        selection: widget.textBaseLine != null
            ? _textBaseline.firstWhere((SelectionItem<TextBaseline> item) =>
                item.value == widget.textBaseLine)
            : _textBaseline.first,
        collection: _textBaseline,
        onValueChanged: (SelectionItem<TextBaseline> textBaseline) =>
            widget.onTextBaselineChanged(textBaseline.value),
      ),
    ];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                widget.label,
                style: textTheme.headline6,
                textAlign: TextAlign.left,
              ),
              IconButton(
                icon: Icon(
                    expanded ? Icons.indeterminate_check_box : Icons.add_box),
                onPressed: toggle,
                color: Colors.blueGrey.shade600,
              )
            ],
          ),
        ]
          ..addAll(expanded ? controls : [])
          ..add(Divider()),
      ),
    );
  }

  void toggle() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('expanded', expanded));
  }
}
