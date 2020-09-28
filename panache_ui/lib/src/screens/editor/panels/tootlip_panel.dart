import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'tooltipTheme';

class TooltipThemePanel extends StatelessWidget {
  final ThemeModel model;
  TooltipThemeData get currentTheme => myTheme.tooltipTheme;
  const TooltipThemePanel(this.model, {Key key}) : super(key: key);

  ThemeData get myTheme => model.theme;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = currentTheme.textStyle ?? createDefaultTextStyle();

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              SwitcherControl(
                checked: currentTheme.excludeFromSemantics ?? false,
                checkedLabel: 'excludeFromSemantics',
                direction: Axis.vertical,
                onChange: (bool value) => _updateCurrentTheme(
                    currentTheme.copyWith(excludeFromSemantics: value)),
              ),
              SliderPropertyControl(
                currentTheme.height ?? 1,
                (double value) =>
                    _updateCurrentTheme(currentTheme.copyWith(height: value)),
                label: 'height',
                max: 64,
                maxWidth: 140,
                vertical: true,
              ),
            ],
          ),
          const Divider(
            height: 32,
          ),
          getFieldsRow(<Widget>[
            SwitcherControl(
              checked: currentTheme.preferBelow ?? true,
              checkedLabel: 'preferBelow ',
              direction: Axis.vertical,
              onChange: (bool value) => _updateCurrentTheme(
                  currentTheme.copyWith(preferBelow: value)),
            ),
            SliderPropertyControl(
              currentTheme?.verticalOffset ?? 1.0,
              (double value) => _updateCurrentTheme(
                  currentTheme.copyWith(verticalOffset: value)),
              label: 'verticalOffset',
              max: 20,
              maxWidth: 20,
              vertical: true,
            ),
          ]),
          const Divider(
            height: 32,
          ),
          const Text('textStyle'),
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

  void _onBrightnessChanged(Brightness value, {TextStyle labelStyle}) {
    ThemeData updatedTheme = model.theme.copyWith(
      brightness: value,
    );
    model.updateTheme(updatedTheme);
  }

  void _updateCurrentTheme(TooltipThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(tooltipTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
    properties.add(
        DiagnosticsProperty<TooltipThemeData>('currentTheme', currentTheme));
  }
}
