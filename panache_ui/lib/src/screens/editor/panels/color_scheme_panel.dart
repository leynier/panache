import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/color_scheme_control.dart';
import 'package:panache_ui/src/screens/editor/controls/drop_down_control.dart';
import 'package:panache_ui/src/screens/editor/controls/shape_form_control.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import 'package:panache_ui/src/screens/editor/controls/text_style_control.dart';
import '../controls/color_selector.dart';
import '../controls/switcher_control.dart';
import '../editor_utils.dart';

String _themeRef = 'colorScheme';

class ColorSchemeThemePanel extends StatelessWidget {
  final ThemeModel model;
  ColorSchemeThemePanel(this.model, {Key key}) : super(key: key);

  ThemeData get myTheme => model.theme;
  ColorScheme get currentTheme => myTheme.colorScheme;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          ColorSchemeControl(
            scheme: myTheme.colorScheme,
            onSchemeChanged: (ColorScheme scheme) =>
                _updateTheme(myTheme.copyWith(colorScheme: scheme)),
          )
        ],
      ),
    );
  }

  void _updateTheme(ThemeData theme) {
    model.updateTheme(theme);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ThemeData>('myTheme', myTheme));
  }
}
