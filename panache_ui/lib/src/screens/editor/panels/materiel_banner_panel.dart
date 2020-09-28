import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';

import '../controls/color_selector.dart';
import '../editor_utils.dart';

String _themeRef = 'bannerTheme';

class MaterialBannerThemePanel extends StatelessWidget {
  final ThemeModel model;
  const MaterialBannerThemePanel(this.model, {Key key}) : super(key: key);

  MaterialBannerThemeData get currentTheme => myTheme.bannerTheme;
  ThemeData get myTheme => model.theme;
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
                'backgroundColor',
                currentTheme.backgroundColor ?? model.theme.colorScheme.surface,
                (Color color) => _updateCurrentTheme(
                    currentTheme.copyWith(backgroundColor: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
            ],
          ),
          const Divider(),
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

  void _updateCurrentTheme(MaterialBannerThemeData theme) {
    //Copie du thème dans
    ThemeData updatedTheme = model.theme.copyWith(bannerTheme: theme);

    model.updateTheme(updatedTheme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<MaterialBannerThemeData>(
        'currentTheme', currentTheme));
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
  }
}
