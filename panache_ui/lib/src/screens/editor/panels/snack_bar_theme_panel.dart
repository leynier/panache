import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'snackBarTheme';

class SnackBarThemePanel extends StatelessWidget {
  final ThemeModel model;
  SnackBarThemePanel(this.model, {Key key}) : super(key: key);

  final List<SelectionItem<SnackBarBehavior>> _snackBehavior =
      <SelectionItem<SnackBarBehavior>>[
    const SelectionItem<SnackBarBehavior>(
      'fixed',
      SnackBarBehavior.fixed,
    ),
    const SelectionItem<SnackBarBehavior>(
        'floating', SnackBarBehavior.floating),
  ];

  ThemeData get myTheme => model.theme;
  SnackBarThemeData get currentTheme => myTheme.snackBarTheme;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    TextStyle textStyle =
        currentTheme.contentTextStyle ?? createDefaultTextStyle();

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'actionTextColor',
                currentTheme.actionTextColor ?? myTheme.accentColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(actionTextColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'backgroundColor',
                currentTheme.backgroundColor ?? Colors.transparent,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          const Divider(
            height: 32,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              myTheme.bottomNavigationBarTheme?.elevation ?? 6,
              (double elevation) => _updateCurrentTheme(
                  currentTheme.copyWith(elevation: elevation)),
              label: 'Elevation',
              max: 20,
              maxWidth: 20,
              vertical: true,
            ),
            ColorSelector(
              'disabledActionTextColor',
              currentTheme.disabledActionTextColor ?? Colors.transparent,
              (Color color) => _updateCurrentTheme(
                  currentTheme.copyWith(disabledActionTextColor: color)),
              padding: 2,
              maxLabelWidth: 250,
            ),
          ]),
          getFieldsRow(<Widget>[
            PanacheDropdown<SelectionItem<SnackBarBehavior>>(
              label: 'behavior',
              selection: currentTheme.behavior != null
                  ? _snackBehavior.firstWhere(
                      (SelectionItem<SnackBarBehavior> item) =>
                          item.value == currentTheme.behavior)
                  : _snackBehavior.first,
              collection: _snackBehavior,
              onValueChanged: (SelectionItem<SnackBarBehavior> value) =>
                  _updateCurrentTheme(
                      currentTheme.copyWith(behavior: value.value)),
            ),
            ShapeFormControl(
              onShapeChanged: (ShapeBorder shape) =>
                  _updateCurrentTheme(currentTheme.copyWith(shape: shape)),
              shape: currentTheme.shape,
              //labelStyle: labelStyle,
              direction: Axis.vertical,
            )
          ]),
          const Divider(
            height: 32,
          ),
          Text('contentTextStyle', style: appTextTheme.subtitle1),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'contentTextStyle',
            textStyle: textStyle,
            label: 'contentTextStyle',
            styleName: 'contentTextStyle',
          ),
        ],
      ),
    );
  }

  void _updateCurrentTheme(SnackBarThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(snackBarTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
  }
}
