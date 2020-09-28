import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panache_core/panache_core.dart';

abstract class ThemeService<D, F> {
  final Function(String, String) themeExporter;
  final Function(String, Map<String, dynamic>) themeExporterToJSON;

  final Future<D> Function() dirProvider;
  D _dir;
  D get dir => _dir;

  ThemeData _theme;
  ThemeData get theme => _theme;

  ThemeData _themeLight;
  ThemeData _themeDark;

  List<F> _themes;
  List<F> get themes => _themes;

  VoidCallback _onChange;

  ThemeService(
      {this.themeExporter, this.dirProvider, this.themeExporterToJSON});

  init(VoidCallback onChange) {
    _onChange = onChange;
    if (dirProvider != null)
      dirProvider().then((dir) {
        _dir = dir;
        _onChange();
      });
  }

  ThemeData _localize(ThemeData theme) =>
      ThemeData.localize(theme, Typography.englishLike2018);

  void initTheme(
      {MaterialColor primarySwatch: Colors.blue,
      Brightness brightness: Brightness.light}) {
    //final inputTheme = InputDecoration().applyDefaults(InputDecorationTheme());
    _themeLight = null;
    _themeDark = null;

    _theme = ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: primarySwatch,
      brightness: brightness,
      platform: TargetPlatform.iOS
      /*Platform.isAndroid
             ? TargetPlatform.android
             : TargetPlatform.iOS*/

      ,
    );

    _setThemeByBrightness(_theme, replace: true);
  }

  void updateTheme(ThemeData newTheme) {
    _setThemeByBrightness(newTheme, replace: true);
    _propSetThemeByBrightness(newTheme.brightness);
  }

  void _setThemeByBrightness(ThemeData newTheme, {bool replace = false}) {
    if (replace == true) {
      if (newTheme.brightness == Brightness.dark) {
        _themeDark = newTheme;
      } else {
        _themeLight = newTheme;
      }
    } else {
      if (newTheme.brightness == Brightness.dark) {
        _themeDark ??= newTheme;
      } else {
        _themeLight ??= newTheme;
      }
    }
  }

  ThemeData _getThemeByBrightness(Brightness brightness) =>
      brightness == Brightness.dark ? _themeDark : _themeLight;

  void loadThemeByBrightness(ThemeData newTheme) {
    _setThemeByBrightness(newTheme);
    _propSetThemeByBrightness(newTheme.brightness);
  }

  void _propSetThemeByBrightness(Brightness brightness) =>
      _theme = _getThemeByBrightness(brightness);

  void exportTheme({String filename, String code}) =>
      themeExporter(code, filename);

  void exportThemeToJSON({String filename, Map<String, dynamic> code}) =>
      themeExporterToJSON(filename, code);

  void saveTheme(String filename);

  Future<ThemeData> loadTheme(String path);

  bool themeExists(String path) {}
}
