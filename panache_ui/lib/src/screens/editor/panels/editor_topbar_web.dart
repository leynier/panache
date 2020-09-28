import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/src/screens/editor/drive_menu.dart';

class WebPanacheEditorTopbar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isMobileInPortrait;
  final ThemeModel model;
  final bool showCode;
  final ValueChanged<bool> onShowCodeChanged;

  const WebPanacheEditorTopbar(
      {this.isMobileInPortrait,
      this.model,
      this.showCode,
      this.onShowCodeChanged,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Text title = Text.rich(TextSpan(text: 'Panache', children: [
      TextSpan(
          text: ' alpha',
          style: textTheme.caption.copyWith(color: Colors.blueGrey.shade900))
    ]));

    if (isMobileInPortrait) {
      return AppBar(
        title: title,
        leading: IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () => Scaffold.of(context).openDrawer()),
        actions: [
          IconButton(
            icon: Icon(showCode ? Icons.mobile_screen_share : Icons.keyboard),
            onPressed: () => onShowCodeChanged(!showCode),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: saveThemeToDart),
        ],
      );
    }

    return AppBar(
      title: title,
      actions: <Widget>[
        FlatButton.icon(
          textColor: Colors.blueGrey.shade50,
          icon: const Icon(Icons.mobile_screen_share),
          label: const Text('App preview'),
          onPressed: showCode ? () => onShowCodeChanged(false) : null,
        ),
        FlatButton.icon(
          textColor: Colors.blueGrey.shade50,
          icon: const Icon(Icons.keyboard),
          label: const Text('Code preview'),
          onPressed: showCode ? null : () => onShowCodeChanged(true),
        ),
        Tooltip(
            message: "Export theme do dart file.",
            child: IconButton(
                icon: const Icon(Icons.file_download),
                onPressed: saveThemeToDart)),
        Tooltip(
            message: "Export theme do JSON file.",
            child: IconButton(
                icon: const Icon(Icons.file_download),
                onPressed: saveThemeToJSON)),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  void saveThemeToDart() {
    model.exportTheme(name: 'theme.dart');
  }

  void saveThemeToJSON() {
    model.exportThemeToJSON();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<bool>('isMobileInPortrait', isMobileInPortrait));
    properties.add(DiagnosticsProperty<ThemeModel>('model', model));
    properties.add(DiagnosticsProperty<bool>('showCode', showCode));
    properties.add(ObjectFlagProperty<Function(bool)>.has(
        'onShowCodeChanged', onShowCodeChanged));
  }
}
