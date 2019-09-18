import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:panache_core/src/data/subtheme.dart';

import '../utils/color_utils.dart';
import 'theme_config.dart';

class PanacheTheme {
  final String id;
  final String name;
  final ColorSwatch primarySwatch;
  final Brightness brightness;
  final ThemeConfiguration config;
  ThemeData themeData;

  /// [ThemeData]
  /// initialize a [ThemeData] from primarySwatch
  /// primaryColors are generated from the primarySwath
  /// Needs to be a ColorSwatch
  PanacheTheme({
    @required this.id,
    @required this.name,
    @required this.primarySwatch,
    @required this.brightness,
    @required this.config,
    this.themeData,
  }) {
    themeData ??= ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: primarySwatch,
      brightness: brightness,
      // FIXME default to ios but should detect device type + allow platform switch
      platform: TargetPlatform.iOS,
    );
  }

  factory PanacheTheme.fromJson(String data) {
    final rawTheme = json.decode(data);
    return PanacheTheme(
      id: rawTheme['id'],
      name: rawTheme['name'],
      primarySwatch: swatchFor(color: Color(rawTheme['primarySwatch'])),
      brightness: Brightness.values[rawTheme['brightness']],
      config: null,
    );
  }

  void isActivated(Subtheme subtheme) => config.isActivated(subtheme);

  void activate(Subtheme subtheme, bool value) =>
      config.activate(subtheme, value);

  String toJson() {
    final data = {
      'id': id,
      'name': name,
      'primarySwatch': primarySwatch.value,
      'brightness': Brightness.values.indexOf(brightness),
    };
    return json.encode(data);
  }

  @override
  String toString() {
    return 'PanacheTheme{'
        'id: $id, name: $name, '
        'primarySwatch: $primarySwatch, '
        'brightness: $brightness'
        '}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PanacheTheme &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          primarySwatch == other.primarySwatch;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ primarySwatch.hashCode;
}
