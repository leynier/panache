import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/panache_ui.dart';
import 'package:panache_web/src/web_link_service.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:provider/provider.dart';
import 'dart:js' as js;
import 'dart:html' as html;
import 'src/theme_exporter_web.dart';
import 'src/web_local_data.dart';
import 'src/web_theme_service.dart';

void main() async {
  clearPersisted();
  final localData = WebLocalData();
  await localData.init();

  final themeModel = ThemeModel(
    localData: localData,
    service: WebThemeService(
      themeExporter: exportTheme,
      themeExporterToJSON: exportThemeToJSON,
      dirProvider: null,
    ),
  );

  runApp(PanacheApp(themeModel: themeModel));
}

class PanacheApp extends StatelessWidget {
  final ThemeModel themeModel;

  const PanacheApp({Key key, @required this.themeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ScopedModel<ThemeModel>(
      model: themeModel,
      child: MultiProvider(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: /*panacheTheme*/ buildAppTheme(theme, panachePrimarySwatch),
          home: LaunchScreen(model: themeModel),
          routes: {
            '/home': (BuildContext context) => LaunchScreen(model: themeModel),
            '/editor': (BuildContext context) => PanacheEditorScreen(),
          },
        ),
        providers: <SingleChildCloneableWidget>[
          Provider<LinkService>.value(value: WebLinkService())
        ],
      ),
    );
  }
}

exportTheme(String code, String filename) async {
  print('exportTheme... $code');
  jsSaveTheme(code, filename, (success) => print('export $success'));
}

exportThemeToJSON(String filename, Map<String, dynamic> code) async {
  if (code.isNotEmpty) {
    print('exportTheme To JSON ${filename} ... $code');
    String myJSON = jsonEncode(code);
    print('JSON GENERATED $myJSON');

    //String text = 'this is the text file';
    List<int> bytes = utf8.encode(myJSON);

    dynamic script =
        html.document.createElement('script') as html.ScriptElement;
    script.src = "http://cdn.jsdelivr.net/g/filesaver.js";
    /*html.ScriptElement script = html.ScriptElement()
      ..src = "http://cdn.jsdelivr.net/g/filesaver.js";*/

    html.document.body.nodes.add(script);

// calls the "saveAs" method from the FileSaver.js libray
    js.context.callMethod("saveAs", <dynamic>[
      html.Blob([bytes]),
      filename, //File Name (optional) defaults to "download"
      "application/json" //File Type (optional)
    ]);

    // cleanup
    html.document.body.nodes.remove(script);
  }
}
