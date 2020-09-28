import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'toggleButtonsTheme';

class ToggleButtonThemePanel extends StatelessWidget {
  final ThemeModel model;
  const ToggleButtonThemePanel(this.model, {Key key}) : super(key: key);

  ThemeData get myTheme => model.theme;
  ToggleButtonsThemeData get currentTheme => myTheme.toggleButtonsTheme;

  @override
  Widget build(BuildContext context) {
    //TextTheme appTextTheme = Theme.of(context).textTheme;
    TextStyle textStyle = currentTheme.textStyle ?? createDefaultTextStyle();

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'Color',
                currentTheme?.color ?? Theme.of(context).colorScheme.onSurface,
                (Color color) =>
                    _updateCurrentTheme(currentTheme.copyWith(color: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'fillColor',
                currentTheme?.fillColor ?? Colors.transparent,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(fillColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'focusColor',
                currentTheme?.focusColor ?? Theme.of(context).focusColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(focusColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'highlightColor',
                currentTheme?.highlightColor ??
                    Theme.of(context).highlightColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(highlightColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'hoverColor',
                currentTheme?.hoverColor ?? Theme.of(context).hoverColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(hoverColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'splashColor',
                currentTheme?.splashColor ?? Theme.of(context).splashColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(splashColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'borderColor',
                currentTheme?.borderColor ??
                    Theme.of(context).colorScheme.onSurface,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(borderColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SliderPropertyControl(
                currentTheme?.borderWidth ?? 1.0,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(borderWidth: value)),
                label: 'borderWidth',
                max: 20,
                maxWidth: 20,
                vertical: true,
              ),
            ],
          ),
          const Divider(),
          const Text('textstyle'),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'textstyle',
            textStyle: textStyle,
            label: 'textStyle',
            styleName: 'textStyle',
          ),
        ],
      ),
    );
  }

  void _updateCurrentTheme(ToggleButtonsThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(toggleButtonsTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
    properties.add(DiagnosticsProperty<ToggleButtonsThemeData>(
        'currentTheme', currentTheme));
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
  }
}
