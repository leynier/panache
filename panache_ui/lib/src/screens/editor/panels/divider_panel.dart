import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';

import '../controls/color_selector.dart';
import '../editor_utils.dart';

String _themeRef = 'dividerTheme';

class DividerThemePanel extends StatelessWidget {
  final ThemeModel model;
  const DividerThemePanel(this.model, {Key key}) : super(key: key);

  DividerThemeData get currentTheme => myTheme.dividerTheme;
  ThemeData get myTheme => model.theme;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'color',
                currentTheme.color ?? model.theme.dividerColor,
                (Color color) =>
                    _updateCurrentTheme(currentTheme.copyWith(color: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                currentTheme.indent ?? 0,
                (double value) =>
                    _updateCurrentTheme(currentTheme.copyWith(indent: value)),
                label: 'indent',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
              SliderPropertyControl(
                currentTheme.endIndent ?? 0,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(endIndent: value)),
                label: 'endIndent',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                currentTheme.space ?? 1,
                (double value) =>
                    _updateCurrentTheme(currentTheme.copyWith(space: value)),
                label: 'space',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
              SliderPropertyControl(
                currentTheme.thickness ?? 0,
                (double value) => _updateCurrentTheme(
                    currentTheme.copyWith(thickness: value)),
                label: 'thickness',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _updateCurrentTheme(DividerThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(dividerTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
    properties.add(
        DiagnosticsProperty<DividerThemeData>('currentTheme', currentTheme));
  }
}
