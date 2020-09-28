import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import '../../../help/help.dart';
import '../controls/color_selector.dart';
import '../editor_utils.dart';

class ThemeColorPanel extends StatelessWidget {
  final ThemeModel themeModel;

  ThemeData get theme => themeModel.theme;

  const ThemeColorPanel(this.themeModel, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade100,
      padding: kPadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          getColorBrightnessSelector(
            label: 'Primary color',
            currentColor: theme.primaryColor,
            help: primaryColorHelp,
            changeHandler: (Color color) =>
                themeModel.updateColor(property: "primaryColor", color: color),
            isDark: theme.primaryColorBrightness == Brightness.dark,
            brightnessChangeHandler: (bool isDark) =>
                _onPrimaryBrightnessChanged(
              themeModel,
              isDark ? Brightness.dark : Brightness.light,
            ),
          ),
          getFieldsRow(<Widget>[
            /* FIXME disabled => visible */
            ColorSelector(
              'Primary color light ( generated )',
              theme.primaryColorLight,
              null,
              /*(Color color) => themeModel.updateColor(
                  property: "primaryColorLight", color: color),*/
              padding: 2,
            ),
            ColorSelector(
              'Primary color dark',
              theme.primaryColorDark,
              (Color color) => themeModel.updateColor(
                  property: "primaryColorDark", color: color),
              padding: 2,
            ),
          ]),
          getColorBrightnessSelector(
            label: 'Accent color',
            currentColor: theme.accentColor,
            help: accentColorHelp,
            changeHandler: (Color color) =>
                themeModel.updateColor(property: "accentColor", color: color),
            isDark: theme.accentColorBrightness == Brightness.dark,
            brightnessChangeHandler: (bool isDark) =>
                _onAccentBrightnessChanged(
              themeModel,
              isDark ? Brightness.dark : Brightness.light,
            ),
          ),
          getColorBrightnessSelector(
            label: 'Scaffold background color',
            currentColor: theme.scaffoldBackgroundColor,
            changeHandler: (Color color) => themeModel.updateColor(
                property: "scaffoldBackgroundColor", color: color),
            isDark: theme.brightness == Brightness.dark,
            brightnessChangeHandler: (bool isDark) {
              ThemeData updatedTheme = theme.copyWith(
                  brightness: isDark ? Brightness.dark : Brightness.light);
              themeModel.updateTheme(updatedTheme);
            },
          ),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Button color',
              theme.buttonColor,
              (Color color) => themeModel.updateTheme(theme.copyWith(
                  buttonColor: color,
                  buttonTheme: theme.buttonTheme.copyWith(buttonColor: color))),
              padding: 2,
            ),
            ColorSelector(
              'Disabled color',
              theme.disabledColor,
              (Color color) => themeModel.updateTheme(theme.copyWith(
                  disabledColor: color,
                  buttonTheme:
                      theme.buttonTheme.copyWith(disabledColor: color))),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Canvas color',
              theme.canvasColor,
              (Color color) =>
                  themeModel.updateColor(property: "canvasColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Card color',
              theme.cardColor,
              (Color color) =>
                  themeModel.updateColor(property: "cardColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Unselected widget color',
              theme.unselectedWidgetColor,
              (Color color) => themeModel.updateColor(
                  property: "unselectedWidgetColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Toggleable Active Color',
              theme.toggleableActiveColor,
              (Color color) => themeModel.updateColor(
                  property: "toggleableActiveColor", color: color),
              padding: 2,
            )
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'BottomAppBar color',
              theme.bottomAppBarColor,
              (Color color) => themeModel.updateColor(
                  property: "bottomAppBarColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Text cursor color',
              theme.cursorColor,
              (Color color) =>
                  themeModel.updateColor(property: "cursorColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Error color',
              theme.errorColor,
              (Color color) =>
                  themeModel.updateColor(property: "errorColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Hint color',
              theme.hintColor,
              (Color color) =>
                  themeModel.updateColor(property: "hintColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Highlight color',
              theme.highlightColor,
              (Color color) => themeModel.updateColor(
                  property: "highlightColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Splash color',
              theme.splashColor,
              (Color color) =>
                  themeModel.updateColor(property: "splashColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Indicator color',
              theme.indicatorColor,
              (Color color) => themeModel.updateColor(
                  property: "indicatorColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Dialog background color',
              theme.dialogBackgroundColor,
              (Color color) => themeModel.updateColor(
                  property: "dialogBackgroundColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Divider color',
              theme.dividerColor,
              (Color color) => themeModel.updateColor(
                  property: "dividerColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Secondary header widget color',
              theme.secondaryHeaderColor,
              (Color color) => themeModel.updateColor(
                  property: "secondaryHeaderColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Selected row color',
              theme.selectedRowColor,
              (Color color) => themeModel.updateColor(
                  property: "selectedRowColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Background color',
              theme.backgroundColor,
              (Color color) => themeModel.updateColor(
                  property: "backgroundColor", color: color),
              padding: 2,
            ),
          ]),
          getFieldsRow(<Widget>[
            ColorSelector(
              'Text selection color',
              theme.textSelectionColor,
              (Color color) => themeModel.updateColor(
                  property: "textSelectionColor", color: color),
              padding: 2,
            ),
            ColorSelector(
              'Text selection handler color',
              theme.textSelectionHandleColor,
              (Color color) => themeModel.updateColor(
                  property: "textSelectionHandleColor", color: color),
              padding: 2,
            ),
          ]),
          /*ColorSchemeControl(
            scheme: theme.colorScheme,
            onSchemeChanged: (scheme) =>
                themeModel.updateTheme(theme.copyWith(colorScheme: scheme)),
          )*/
        ],
      ),
    );
  }

  void _onPrimaryBrightnessChanged(
      ThemeModel themeModel, Brightness brightness) {
    themeModel.updateTheme(theme.copyWith(primaryColorBrightness: brightness));
  }

  void _onAccentBrightnessChanged(
          ThemeModel themeModel, Brightness brightness) =>
      themeModel.updateTheme(theme.copyWith(accentColorBrightness: brightness));
}
