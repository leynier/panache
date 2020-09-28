import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';

import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import 'package:panache_ui/src/screens/editor/panels/input_decoration_theme_panel.dart';
import '../controls/color_selector.dart';
import '../editor_utils.dart';

String _themeRef = 'timePickerTheme';

class TimePickerThemePanel extends StatelessWidget {
  final ThemeModel model;
  const TimePickerThemePanel(this.model, {Key key}) : super(key: key);
  TimePickerThemeData get currentTheme => myTheme.timePickerTheme;
  ThemeData get myTheme => model.theme;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    TextStyle dayPeriodTextStyle =
        currentTheme.dayPeriodTextStyle ?? createDefaultTextStyle();
    TextStyle helpTextStyle =
        currentTheme.helpTextStyle ?? createDefaultTextStyle();
    TextStyle hourMinuteTextStyle =
        currentTheme.hourMinuteTextStyle ?? createDefaultTextStyle();
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'backgroundColor',
                currentTheme?.backgroundColor ??
                    Theme.of(context).colorScheme?.surface,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'dayPeriodColor',
                currentTheme?.dayPeriodColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(dayPeriodColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'dayPeriodTextColor',
                currentTheme?.dayPeriodTextColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(dayPeriodTextColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'dialBackgroundColor',
                currentTheme?.dialBackgroundColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(dialBackgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'dialHandColor',
                currentTheme?.dialHandColor ?? myTheme.colorScheme?.primary,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(dialHandColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'dialTextColor',
                currentTheme?.dialTextColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(dialTextColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'entryModeIconColor',
                currentTheme?.entryModeIconColor ??
                    Theme.of(context).colorScheme?.onSurface?.withOpacity(
                          Theme.of(context).colorScheme?.brightness ==
                                  Brightness.dark
                              ? 1.0
                              : 0.6,
                        ),
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(entryModeIconColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              ColorSelector(
                'hourMinuteColor',
                currentTheme?.hourMinuteColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(hourMinuteColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'hourMinuteTextColor',
                currentTheme?.hourMinuteTextColor,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(hourMinuteTextColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              ShapeFormControl(
                onShapeChanged: (ShapeBorder shape) => _updateCurrentTheme(
                    currentTheme.copyWith(hourMinuteShape: shape)),
                shape: currentTheme.hourMinuteShape,
                //labelStyle: labelStyle,
                direction: Axis.vertical,
              ),
              ShapeFormControl(
                onShapeChanged: (ShapeBorder shape) =>
                    _updateCurrentTheme(currentTheme.copyWith(shape: shape)),
                shape: currentTheme.shape,
                //labelStyle: labelStyle,
                direction: Axis.vertical,
              ),
            ],
          ),
          const Divider(
            height: 32,
          ),
          Text('dayPeriodTextStyle', style: appTextTheme.subtitle1),
          const Divider(
            height: 32,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'dayPeriodTextStyle',
            textStyle: dayPeriodTextStyle,
            label: 'dayPeriodTextStyle',
            styleName: 'dayPeriodTextStyle',
          ),
          Text('helpTextStyle', style: appTextTheme.subtitle1),
          const Divider(
            height: 32,
          ),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'helpTextStyle',
            textStyle: helpTextStyle,
            label: 'helpTextStyle',
            styleName: 'helpTextStyle',
          ),
          const Divider(
            height: 32,
          ),
          Text('hourMinuteTextStyle', style: appTextTheme.subtitle1),
          buildTextStyleControl(
            _themeRef,
            model,
            currentTheme.copyWith,
            key: 'hourMinuteTextStyle',
            textStyle: hourMinuteTextStyle,
            label: 'hourMinuteTextStyle',
            styleName: 'hourMinuteTextStyle',
          ),
          const Divider(
            height: 32,
          ),
          Text('inputDecorationTheme', style: appTextTheme.subtitle1),
          InputDecorationThemePanel(
            model,
            currentTheme.inputDecorationTheme,
            currentThemeCopyWith: currentTheme.copyWith,
            modelParamRef: 'timePickerTheme',
          ),
        ],
      ),
    );
  }

  void _updateCurrentTheme(TimePickerThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(timePickerTheme: theme);

    model.updateTheme(updatedTheme);
  }
}
