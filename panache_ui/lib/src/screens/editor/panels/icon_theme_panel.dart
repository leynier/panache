import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import '../controls/color_selector.dart';
import '../controls/slider_control.dart';
import '../editor_utils.dart';

final showIndicatorOptions = [
  ShowValueIndicator.always,
  ShowValueIndicator.never,
  ShowValueIndicator.onlyForContinuous,
  ShowValueIndicator.onlyForDiscrete,
];

class IconThemePanel extends StatelessWidget {
  final ThemeModel model;

  IconThemeData get iconTheme => model.theme.iconTheme;

  IconThemeData get primaryIconTheme => model.theme.primaryIconTheme;

  IconThemeData get accentIconTheme => model.theme.accentIconTheme;

  const IconThemePanel(this.model, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Icon theme', style: textTheme.subtitle1),
          ColorSelector(
            'Color',
            iconTheme.color,
            (Color color) => _updateIconTheme(iconTheme.copyWith(color: color)),
            padding: 4,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              iconTheme.size ?? 12,
              (double size) => _updateIconTheme(iconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              maxWidth: 140,
              vertical: true,
            ),
            SliderPropertyControl(
              iconTheme.opacity ?? 1,
              (double opacity) =>
                  _updateIconTheme(iconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0,
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          Divider(
            height: 32,
          ),
          Text('Primary icon theme', style: textTheme.subtitle1),
          ColorSelector(
            'Color',
            primaryIconTheme.color,
            (Color color) => _updatePrimaryIconTheme(
                primaryIconTheme.copyWith(color: color)),
            padding: 0,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              primaryIconTheme.size ?? 12,
              (double size) => _updatePrimaryIconTheme(
                  primaryIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              vertical: true,
            ),
            SliderPropertyControl(
              primaryIconTheme.opacity ?? 1,
              (double opacity) => _updatePrimaryIconTheme(
                  primaryIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0,
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
          Divider(
            height: 32,
          ),
          Text('Accent icon theme', style: textTheme.subtitle1),
          ColorSelector(
            'Color',
            accentIconTheme.color,
            (Color color) =>
                _updateAccentIconTheme(accentIconTheme.copyWith(color: color)),
            padding: 0,
          ),
          getFieldsRow(<Widget>[
            SliderPropertyControl(
              accentIconTheme.size ?? 12,
              (double size) =>
                  _updateAccentIconTheme(accentIconTheme.copyWith(size: size)),
              label: 'Size',
              min: 8,
              max: 64,
              vertical: true,
            ),
            SliderPropertyControl(
              accentIconTheme.opacity ?? 1,
              (double opacity) => _updateAccentIconTheme(
                  accentIconTheme.copyWith(opacity: opacity)),
              label: 'Opacity',
              min: 0,
              max: 1,
              vertical: true,
              showDivisions: false,
            ),
          ]),
        ],
      ),
    );
  }

  void _updateIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(iconTheme: iconTheme));

  void _updatePrimaryIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(primaryIconTheme: iconTheme));

  void _updateAccentIconTheme(IconThemeData iconTheme) =>
      model.updateTheme(model.theme.copyWith(accentIconTheme: iconTheme));
}
