import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/controls/slider_control.dart';
import '../controls/color_selector.dart';
import '../editor_utils.dart';

String _themeRef = 'bottomAppBarTheme';

class BottomAppBarThemePanel extends StatelessWidget {
  final ThemeModel model;
  const BottomAppBarThemePanel(this.model, {Key key}) : super(key: key);

  ThemeData get myTheme => model.theme;

  @override
  Widget build(BuildContext context) {
    TextTheme appTextTheme = Theme.of(context).textTheme;

    return Container(
      padding: kPadding,
      color: Colors.grey.shade100,
      child: Column(
        children: <Widget>[
          getFieldsRow(
            <Widget>[
              ColorSelector(
                'Color',
                model.theme.bottomAppBarTheme?.color ??
                    model.theme.bottomAppBarColor,
                (Color color) => _updateAppBarTheme(
                    myTheme.bottomAppBarTheme.copyWith(color: color)),
                padding: 2,
                maxLabelWidth: 250,
              ),
              SliderPropertyControl(
                myTheme.bottomAppBarTheme?.elevation ?? 8,
                (double elevation) => _updateAppBarTheme(
                    myTheme.bottomAppBarTheme.copyWith(elevation: elevation)),
                label: 'Elevation',
                min: 0,
                max: 20,
                maxWidth: 20,
                vertical: true,
              ),
            ],
          ),
          Divider(
            height: 32,
          ),
          Text('shape Non géré', style: appTextTheme.subtitle1),
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

  _updateMyTheme(ThemeData myTheme) {
    //ThemeData updatedTheme = model.theme.copyWith(appBarTheme: appBarTheme);
    model.updateTheme(myTheme /*updatedTheme*/);
  }

  _updateAppBarTheme(BottomAppBarTheme bottomAppBarTheme) {
    //Copie du thème dans
    ThemeData updatedTheme =
        model.theme.copyWith(bottomAppBarTheme: bottomAppBarTheme);

    model.updateTheme(updatedTheme);
  }
}
