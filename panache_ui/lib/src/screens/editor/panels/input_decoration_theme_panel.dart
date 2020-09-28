import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';

import '../controls/color_selector.dart';
import '../controls/inputs_border_control.dart';
import '../controls/slider_control.dart';
import '../controls/switcher_control.dart';
import '../controls/text_style_control.dart';
import '../editor_utils.dart';

String _themeRef = 'inputDecorationTheme';

class InputDecorationThemePanel extends StatelessWidget {
  final ThemeModel model;
  final Function currentThemeCopyWith;
  final String modelParamRef;
  //InputDecorationTheme get inputTheme => model.theme.inputDecorationTheme;
  InputDecorationTheme inputTheme;

  InputDecorationThemePanel(this.model, InputDecorationTheme inputThemeToModify,
      {Key key, this.currentThemeCopyWith, this.modelParamRef})
      : super(key: key) {
    inputTheme = inputThemeToModify ?? model.theme.inputDecorationTheme;
  }

  final List<SelectionItem<FloatingLabelBehavior>> _floatingLabelBehaviors =
      <SelectionItem<FloatingLabelBehavior>>[
    SelectionItem<FloatingLabelBehavior>('auto', FloatingLabelBehavior.auto),
    SelectionItem<FloatingLabelBehavior>(
        'always', FloatingLabelBehavior.always),
    SelectionItem<FloatingLabelBehavior>('never', FloatingLabelBehavior.never),
  ];

  @override
  Widget build(BuildContext context) {
    TextStyle baseStyle =
        model.theme.textTheme.caption.copyWith(color: model.theme.hintColor);
    TextStyle helperStyle = inputTheme.helperStyle ?? baseStyle;
    TextStyle labelStyle = inputTheme.labelStyle ?? baseStyle;
    TextStyle hintStyle = inputTheme.hintStyle ?? baseStyle;
    TextStyle errorStyle = inputTheme.errorStyle ??
        baseStyle.copyWith(color: model.theme.errorColor);
    TextStyle counterStyle = inputTheme.counterStyle ?? baseStyle;
    TextStyle prefixStyle = inputTheme.prefixStyle ?? baseStyle;
    TextStyle suffixStyle = inputTheme.suffixStyle ?? baseStyle;

    Orientation orientation = MediaQuery.of(context).orientation;
    bool inPortrait = orientation == Orientation.portrait;
    bool isLargeLayout = MediaQuery.of(context).size.shortestSide >= 600;
    bool useMobileLayout = !inPortrait && !isLargeLayout;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          getFieldsRow(<Widget>[
            SwitcherControl(
              label: 'Filled',
              checked: inputTheme.filled,
              onChange: (bool filled) => _updateInputDecorationTheme(
                  _copyInputDecorationThemeWith(inputTheme, filled: filled)),
            ),
            ColorSelector(
              'Fill color',
              inputTheme.fillColor ?? Colors.white.withAlpha(0),
              (Color color) => _updateInputDecorationTheme(
                  _copyInputDecorationThemeWith(inputTheme,
                      fillColor: color, filled: true)),
              padding: 0,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'focusColor',
              inputTheme.focusColor ?? Colors.white.withAlpha(0),
              (Color color) => _updateInputDecorationTheme(
                  _copyInputDecorationThemeWith(inputTheme,
                      focusColor: color, filled: true)),
              padding: 0,
            ),
            ColorSelector(
              'hoverColor',
              inputTheme.hoverColor ?? Colors.white.withAlpha(0),
              (Color color) => _updateInputDecorationTheme(
                  _copyInputDecorationThemeWith(inputTheme,
                      hoverColor: color, filled: true)),
              padding: 0,
            ),
          ]),
          getFieldsRow(<Widget>[
            InputBorderControl(
              label: 'Border',
              padding: 2,
              axis: Axis.vertical,
              border: inputTheme.border,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(
                    _copyInputDecorationThemeWith(inputTheme, border: value));
              },
            ),
            InputBorderControl(
              label: 'Error border',
              padding: 2,
              axis: Axis.vertical,
              border: inputTheme.errorBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    errorBorder: value));
              },
            )
          ]),
          getFieldsRow(<Widget>[
            InputBorderControl(
              label: 'Enabled border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.enabledBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    enabledBorder: value));
              },
            ),
            InputBorderControl(
              label: 'Disabled border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.disabledBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    disabledBorder: value));
              },
            ),
          ]),
          getFieldsRow(<Widget>[
            InputBorderControl(
              label: 'Focused border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.focusedBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    focusedBorder: value));
              },
            ),
            InputBorderControl(
              label: 'Focused error border',
              axis: Axis.vertical,
              padding: 2,
              border: inputTheme.focusedErrorBorder,
              onShapeChanged: (InputBorder value) {
                _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                    inputTheme,
                    focusedErrorBorder: value));
              },
            ),
          ]),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: getFieldsRow(<Widget>[
              SwitcherControl(
                label: 'Is dense',
                checked: inputTheme.isDense,
                onChange: (value) => _updateInputDecorationTheme(
                    _copyInputDecorationThemeWith(inputTheme, isDense: value)),
              ),
              SwitcherControl(
                  label: 'Is collapsed',
                  checked: inputTheme.isCollapsed,
                  onChange: (value) =>
                      _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                        inputTheme,
                        isCollapsed: value,
                      ))),
            ]),
          ),
          getFieldsRow(<Widget>[
            PanacheDropdown<SelectionItem<FloatingLabelBehavior>>(
              label: 'floatingLabelBehavior ',
              selection: inputTheme.floatingLabelBehavior != null
                  ? _floatingLabelBehaviors.firstWhere(
                      (SelectionItem<FloatingLabelBehavior> item) =>
                          item.value == inputTheme.floatingLabelBehavior)
                  : _floatingLabelBehaviors.first,
              collection: _floatingLabelBehaviors,
              onValueChanged: (SelectionItem<FloatingLabelBehavior>
                      floatingLabelBehavior) =>
                  _updateInputDecorationTheme(inputTheme.copyWith(
                      floatingLabelBehavior: floatingLabelBehavior.value)),
            ),
            SwitcherControl(
                label: 'alignLabelWithHint',
                checked: inputTheme.alignLabelWithHint,
                onChange: (bool value) =>
                    _updateInputDecorationTheme(_copyInputDecorationThemeWith(
                      inputTheme,
                      alignLabelWithHint: value,
                    ))),
          ]),
          const Divider(),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-label_style',
            textStyle: labelStyle,
            label: 'Label style',
            styleName: 'labelStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-hint_style',
            textStyle: hintStyle,
            label: 'Hint style',
            styleName: 'hintStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-helper_style',
            textStyle: helperStyle,
            label: 'Helper style',
            styleName: 'helperStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-error_style',
            textStyle: errorStyle,
            label: 'Error style',
            styleName: 'errorStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-prefix_style',
            textStyle: prefixStyle,
            label: 'Prefix style',
            styleName: 'prefixStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-suffix_style',
            textStyle: suffixStyle,
            label: 'Suffix style',
            styleName: 'suffixStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            _copyInputDecorationThemeWith,
            key: 'ctrl-counter_style',
            textStyle: counterStyle,
            label: 'Counter style',
            styleName: 'counterStyle',
            useMobileLayout: useMobileLayout,
            positionalArguments: <dynamic>[inputTheme],
            currentThemeCopyWith: currentThemeCopyWith,
            modelParamRef: modelParamRef,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Container(
              color: Colors.white70,
              padding: const EdgeInsets.all(6),
              child: SliderPropertyControl(
                inputTheme.contentPadding?.vertical ?? 0,
                (double newValue) => _updateInputDecorationTheme(
                    _copyInputDecorationThemeWith(inputTheme,
                        contentPadding: EdgeInsets.all(newValue))),
                label: 'Content Padding',
                max: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _updateInputDecorationTheme(InputDecorationTheme inputTheme) {
    //On sub theme ref
    if (modelParamRef != null && currentThemeCopyWith != null) {
      model.updateTheme(
          Function.apply(model.theme.copyWith, null, <Symbol, dynamic>{
        Symbol(modelParamRef): Function.apply(currentThemeCopyWith, null,
            <Symbol, dynamic>{const Symbol('inputDecorationTheme'): inputTheme})
      }));

      model.updateTheme(model.theme.copyWith());
    }
    //Directly on model.theme
    else {
      model.updateTheme(model.theme.copyWith(inputDecorationTheme: inputTheme));
    }
  }

  /*TextStyleControl _buildTextStyleControl({
    @required String key,
    @required String label,
    @required TextStyle textStyle,
    @required String styleName,
    @required bool useMobileLayout,
  }) {
    return TextStyleControl(
      label,
      key: Key(key),
      useMobileLayout: useMobileLayout,
      style: textStyle,
      maxFontSize: 24,
      onColorChanged: (Color color) =>
          apply(textStyle.copyWith(color: color), styleName),
      onSizeChanged: (double size) =>
          apply(textStyle.copyWith(fontSize: size), styleName),
      onWeightChanged: (isBold) => apply(
          textStyle.copyWith(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
          styleName),
      onFontStyleChanged: (isItalic) => apply(
          textStyle.copyWith(
              fontStyle: isItalic ? FontStyle.italic : FontStyle.normal),
          styleName),
      onLetterSpacingChanged: (double value) =>
          apply(textStyle.copyWith(letterSpacing: value), styleName),
      onLineHeightChanged: (double value) =>
          apply(textStyle.copyWith(height: value), styleName),
      onWordSpacingChanged: (double value) =>
          apply(textStyle.copyWith(wordSpacing: value), styleName),
      onDecorationChanged: (TextDecoration value) =>
          apply(textStyle.copyWith(decoration: value), styleName),
      onDecorationStyleChanged: (TextDecorationStyle value) =>
          apply(textStyle.copyWith(decorationStyle: value), styleName),
      onDecorationColorChanged: (Color value) =>
          apply(textStyle.copyWith(decorationColor: value), styleName),
    );
  }

  void apply(TextStyle style, String styleName) {
    Map<Symbol, dynamic> styleArgs = <Symbol, dynamic>{};
    styleArgs[Symbol(styleName)] = style;

    Map<Symbol, dynamic> args = <Symbol, dynamic>{};
    args[Symbol(_themeRef)] =
        Function.apply(_copyInputDecorationThemeWith, [inputTheme], styleArgs);
    model.updateTheme(Function.apply(model.theme.copyWith, null, args));
  }*/

  InputDecorationTheme _copyInputDecorationThemeWith(InputDecorationTheme theme,
      {InputBorder border,
      EdgeInsetsGeometry contentPadding,
      TextStyle counterStyle,
      InputBorder disabledBorder,
      InputBorder enabledBorder,
      InputBorder errorBorder,
      int errorMaxLines,
      TextStyle errorStyle,
      Color fillColor,
      bool filled,
      InputBorder focusedBorder,
      InputBorder focusedErrorBorder,
      bool hasFloatingPlaceholder,
      TextStyle helperStyle,
      TextStyle hintStyle,
      bool isCollapsed,
      bool isDense,
      TextStyle labelStyle,
      TextStyle prefixStyle,
      TextStyle suffixStyle,
      Color hoverColor,
      Color focusColor,
      FloatingLabelBehavior floatingLabelBehavior,
      bool alignLabelWithHint}) {
    return InputDecorationTheme(
      border: border ?? theme.border,
      contentPadding: contentPadding ?? theme.contentPadding,
      counterStyle: counterStyle ?? theme.counterStyle,
      disabledBorder: disabledBorder ?? theme.disabledBorder,
      enabledBorder: enabledBorder ?? theme.enabledBorder,
      errorBorder: errorBorder ?? theme.errorBorder,
      errorMaxLines: errorMaxLines ?? theme.errorMaxLines,
      errorStyle: errorStyle ?? theme.errorStyle,
      fillColor: fillColor ?? theme.fillColor,
      filled: filled ?? theme.filled,
      focusedBorder: focusedBorder ?? theme.focusedBorder,
      focusedErrorBorder: focusedErrorBorder ?? theme.focusedErrorBorder,
      helperStyle: helperStyle ?? theme.helperStyle,
      hintStyle: hintStyle ?? theme.hintStyle,
      isCollapsed: isCollapsed ?? theme.isCollapsed,
      isDense: isDense ?? theme.isDense,
      labelStyle: labelStyle ?? theme.labelStyle,
      prefixStyle: prefixStyle ?? theme.prefixStyle,
      suffixStyle: suffixStyle ?? theme.suffixStyle,
      hoverColor: hoverColor ?? theme.hoverColor,
      focusColor: focusColor ?? theme.focusColor,
      floatingLabelBehavior:
          floatingLabelBehavior ?? theme.floatingLabelBehavior,
      alignLabelWithHint: alignLabelWithHint ?? theme.alignLabelWithHint,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<Function>(
        'currentThemeCopyWith', currentThemeCopyWith));
    properties.add(StringProperty('modelParamRef', modelParamRef));
    properties.add(
        DiagnosticsProperty<InputDecorationTheme>('inputTheme', inputTheme));
  }
}
