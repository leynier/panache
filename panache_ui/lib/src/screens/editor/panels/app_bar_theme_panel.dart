import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/panels/panels.dart';

import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'appBarTheme';

class AppBarThemePanel extends StatelessWidget {
  final ThemeModel model;

  AppBarTheme get appBarTheme => model.theme.appBarTheme;
  TextTheme get textTheme {
    TextTheme textTheme = model.theme.appBarTheme.textTheme;
    if (textTheme == null) {
      textTheme = model.theme.primaryTextTheme;
    }
    return textTheme;
  }

  IconThemeData get iconTheme {
    IconThemeData iconTheme = model.theme.appBarTheme.iconTheme;
    if (iconTheme == null) {
      iconTheme = IconThemeData(color: model.theme.primaryColor);
    }
    return iconTheme;
  }

  IconThemeData get actionIconTheme {
    IconThemeData iconTheme = model.theme.appBarTheme.actionsIconTheme;
    if (iconTheme == null) {
      iconTheme = IconThemeData(color: model.theme.accentColor);
    }
    return iconTheme;
  }

  const AppBarThemePanel(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;
    //final labelStyle = appTextTheme.subtitle2;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'Color',
                model.theme.appBarTheme.color ?? model.theme.primaryColor,
                (Color color) =>
                    _updateAppBarTheme(appBarTheme.copyWith(color: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SwitcherControl(
                checked: (appBarTheme.brightness ?? model.theme.brightness) ==
                    Brightness.dark,
                checkedLabel: 'Dark',
                direction: Axis.vertical,
                onChange: (bool value) => _onBrightnessChanged(
                    value ? Brightness.dark : Brightness.light,
                    labelStyle: appTextTheme.bodyText2),
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SwitcherControl(
                checked: appBarTheme.centerTitle ?? false,
                checkedLabel: 'CenterTitle',
                direction: Axis.vertical,
                onChange: (bool value) => _updateAppBarTheme(
                    appBarTheme.copyWith(centerTitle: value ?? false)),
              ),
            ],
          ),
          getFieldsRow(
            <Widget>[
              SliderPropertyControl(
                appBarTheme.elevation ?? 2,
                (double elevation) => _updateAppBarTheme(
                    appBarTheme.copyWith(elevation: elevation)),
                label: 'Elevation',
                min: 0,
                max: 20,
                maxWidth: 20,
                vertical: true,
              ),
              ColorSelector(
                'ShadowColor',
                model.theme.appBarTheme.shadowColor ?? Colors.black,
                (Color color) => _updateAppBarTheme(
                    appBarTheme.copyWith(shadowColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          const Divider(),
          Text('Icon theme', style: appTextTheme.subtitle1),
          ColorSelector(
            'Color',
            iconTheme?.color ?? model.theme.primaryIconTheme?.color,
            (Color color) => _updateIconTheme(iconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              iconTheme?.size ?? model.theme.primaryIconTheme.size ?? 20,
              (double size) => _updateIconTheme(iconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
            SliderPropertyControl(
              iconTheme?.opacity ?? model.theme.primaryIconTheme.opacity ?? 0.5,
              (double opacity) =>
                  _updateIconTheme(iconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0,
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          const Divider(
            height: 32,
          ),
          Text('Actions Icon theme', style: appTextTheme.subtitle1),
          ColorSelector(
            'Color',
            actionIconTheme?.color ?? model.theme.iconTheme.color,
            (Color color) =>
                _updateActionsIconTheme(actionIconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              actionIconTheme?.size ?? model.theme.iconTheme.size ?? 20,
              (double size) =>
                  _updateActionsIconTheme(actionIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
            SliderPropertyControl(
              actionIconTheme?.opacity ?? model.theme.iconTheme.opacity ?? 0.5,
              (double opacity) => _updateActionsIconTheme(
                  actionIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          TypographyThemePanel(
            model: model,
            txtTheme: textTheme,
            txtThemeRef: 'textTheme',
            modelParamRef: _themeRef,
            currentThemeCopyWith: model.theme.appBarTheme.copyWith,
          ),
        ],
      ),
    );
  }

  void _onBrightnessChanged(Brightness value, {TextStyle labelStyle}) {
    ThemeData updatedTheme = model.theme.copyWith(
        appBarTheme: appBarTheme.copyWith(
      brightness: value,
    ));
    model.updateTheme(updatedTheme);
  }

  void _updateAppBarTheme(AppBarTheme appBarTheme) {
    ThemeData updatedTheme = model.theme.copyWith(appBarTheme: appBarTheme);
    model.updateTheme(updatedTheme);
  }

  void _updateIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(
          appBarTheme: model.theme.appBarTheme.copyWith(iconTheme: iconTheme)));

  void _updateActionsIconTheme(IconThemeData actionsIconTheme) =>
      model.updateTheme(model.theme.copyWith(
          appBarTheme: model.theme.appBarTheme
              .copyWith(actionsIconTheme: actionsIconTheme)));
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<AppBarTheme>('appBarTheme', appBarTheme));
    properties.add(
        DiagnosticsProperty<IconThemeData>('actionIconTheme', actionIconTheme));
    properties.add(DiagnosticsProperty<TextTheme>('textTheme', textTheme));
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<IconThemeData>('iconTheme', iconTheme));
  }
}
