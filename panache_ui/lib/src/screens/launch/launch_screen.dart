import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:scoped_model/scoped_model.dart';

import 'launch_large_layout.dart';

import 'screenshot_renderer.dart'
    if (dart.library.html) 'web_screenshot_renderer.dart';

class LaunchScreen extends StatefulWidget {
  final ThemeModel model;

  const LaunchScreen({Key key, this.model}) : super(key: key);

  @override
  LaunchScreenState createState() {
    return new LaunchScreenState();
  }
}

class LaunchScreenState extends State<LaunchScreen> {
  ColorSwatch newThemePrimary = Colors.blue;

  Brightness initialBrightness = Brightness.light;

  bool editMode = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final mqSize = MediaQuery.of(context).size;
    print('LaunchScreenState.build... mqSize $mqSize');
    imageCache.clear();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.blueGrey.shade50,
      body: SafeArea(child: ScopedModelDescendant<ThemeModel>(
          builder: (BuildContext context, Widget child, ThemeModel model) {
        return ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: LaunchLayout(
              model: model,
              newThemePrimary: newThemePrimary,
              initialBrightness: initialBrightness,
              onSwatchSelection: onSwatchSelection,
              onBrightnessSelection: onBrightnessSelection,
              newTheme: _newTheme,
              importTheme: _importTheme,
              editMode: editMode,
              toggleEditMode: () => setState(() => editMode = !editMode),
              buildThemeThumbs: _buildThemeThumbs),
        );
      })),
    );
  }

  void onSwatchSelection(ColorSwatch value) =>
      setState(() => newThemePrimary = value);

  void onBrightnessSelection(Brightness value) =>
      setState(() => initialBrightness = value);

  List<Widget> _buildThemeThumbs(List<PanacheTheme> themes,
          {String basePath, Size size}) =>
      themes
          .map<Widget>((f) => ScreenshotRenderer(
                theme: f,
                removable: editMode,
                basePath: basePath,
                onThemeSelection: (PanacheTheme theme) => _loadTheme(theme),
                onDeleteTheme: (PanacheTheme theme) =>
                    widget.model.deleteTheme(theme),
                size: size,
              ))
          .toList();

  _newTheme(ThemeModel model) {
    model.newTheme(
        primarySwatch: newThemePrimary, brightness: initialBrightness);
    _editTheme();
  }

  _editTheme() => Navigator.of(context).pushNamed('/editor');

  Future _loadTheme(PanacheTheme theme) async {
    final result = await widget.model.loadTheme(theme);
    if (result != null)
      _editTheme();
    else
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Error : Can\'t load this theme.'),
        backgroundColor: Colors.red.shade700,
      ));
  }

  _importTheme(ThemeModel model) async {
    await _startFilePicker(model);

    ///model.newTheme(primarySwatch: newThemePrimary, brightness: initialBrightness);
  }

  _startFilePicker(ThemeModel model) async {
    // variable to hold image to be displayed
    var fileUploaded;
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = false;
    uploadInput.accept = ".json,.dart";
    uploadInput.click();

    uploadInput.onChange.listen((Event e) {
      // read file content as dataURL
      List<File> files = uploadInput.files;
      if (files.length == 1) {
        File file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((ProgressEvent e) {
          setState(() {
            fileUploaded = reader.result;
            print(
                "Fichier ${file.name} chargé en mémoire (${fileUploaded.length})");
            _createThemeFromJSON(model, fileUploaded.toString());
          });
        });

        reader.onError.listen((ProgressEvent fileEvent) {
          setState(() {
            print("Some Error occured while reading the file");
          });
        });
        reader.readAsText(file);
      }
    });
  }

  void _createThemeFromJSON(ThemeModel model, String source) {
    //Map<String, dynamic> jsconTheme = jsonDecode(source);

    model.loadThemeFromJSON(source);

    _editTheme();
    print('JSON decoded');
  }
}
