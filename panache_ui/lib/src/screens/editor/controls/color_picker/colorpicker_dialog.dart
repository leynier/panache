import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:panache_core/panache_core.dart';

import './color_pickers.dart';

enum ColorMode { rgb, hsl }

void showColorPicker(
    {BuildContext context,
    Color currentColor,
    ValueChanged<Color> onColor}) async {
  Color selectedColor = await showDialog<Color>(
    context: context,
    builder: (BuildContext context) => ColorPickerDialog(currentColor),
  );
  if (selectedColor == null) {
    return;
  }
  print("showColorPicker color returned $selectedColor");
  onColor(selectedColor);
}

///
/// usage
///
class ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  const ColorPickerDialog(this.currentColor, {Key key}) : super(key: key);

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('currentColor', currentColor));
  }
}

class _ColorPickerDialogState extends State<ColorPickerDialog>
    with TickerProviderStateMixin {
  Color currentColor/*= Colors.red*/;

  TabController tabController;

  int currentTabIndex = 0;

  @override
  void initState() {
    currentColor = widget.currentColor ?? Colors.blue;
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(
        () => setState(() => currentTabIndex = tabController.index));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mQ = MediaQuery.of(context);

    TextStyle buttonStyle = Theme.of(context).textTheme.button;
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      content: mQ.orientation == Orientation.portrait
          ? _buildPortraitPicker()
          : _buildLandscapePicker(),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'CANCEL',
            style: buttonStyle.copyWith(color: Colors.grey),
          ),
        ),
        FlatButton.icon(
          label: const Text('SELECT'),
          icon: Icon(Icons.check_circle, color: currentColor),
          onPressed: () => selectColor(currentColor),
        ),
      ],
    );
  }

  void selectColor(Color color) {
    Navigator.of(context).pop(color);
  }

  void _buildRGBPicker(Orientation orientation) => RGBPicker(
        onColor: (Color color) => setState(() {
          print("Color received $color");
          currentColor = color;
        }),
        color: currentColor,
        orientation: orientation,
      );

  void _buildHSLPicker(Orientation orientation) => HSLPicker(
        onColor: (Color color) => setState(() => currentColor = color),
        color: currentColor,
        orientation: orientation,
      );

  void _buildMaterialPicker() => MaterialPicker(
        onColor: (Color color) => setState(() => currentColor = color),
        color: currentColor,
      );

  _getPicker(int index, Orientation orientation) {
    switch (index) {
      case 0:
        return _buildRGBPicker(orientation);
      case 1:
        return _buildHSLPicker(orientation);
      case 2:
        return _buildMaterialPicker();

      default:
        return _buildRGBPicker(orientation);
    }
  }

  Widget _buildPortraitPicker() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(
          tabs: <Widget>[
            Tab(text: 'RGB'),
            Tab(text: 'HSL'),
            Tab(text: 'Material'),
          ],
          controller: tabController,
          labelColor: Colors.blueGrey,
          isScrollable: true,
        ),
        ColorThumbPreview(
          color: currentColor,
          constraints: const BoxConstraints.expand(height: 60),
        ),
        SizedBox(
          width: 100,
          child: ColorTextField(
              color: currentColor, onColorChanged: _updateColorValue),
        ),
        _getPicker(currentTabIndex, Orientation.portrait),
      ],
    );
  }

  Widget _buildLandscapePicker() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TabBar(
          indicatorPadding: EdgeInsets.all(2),
          tabs: <Widget>[
            Tab(text: 'RGB'),
            Tab(text: 'HSL'),
            Tab(text: 'Material'),
          ],
          controller: tabController,
          labelColor: Colors.blueGrey,
          isScrollable: true,
        ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ColorThumbPreview(
                    color: currentColor,
                    constraints: BoxConstraints.expand(width: 100, height: 60),
                  ),
                  SizedBox(
                    width: 100,
                    child: ColorTextField(
                      color: currentColor,
                      onColorChanged: _updateColorValue,
                    ),
                  )
                ],
              ),
            ),
            _getPicker(currentTabIndex, Orientation.landscape),
          ],
        )
      ],
    );
  }

  void _updateColorValue(Color color) {
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
        setState(() => currentColor = color);
      });
    } else {
      setState(() => currentColor = color);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('currentColor', currentColor));
    properties.add(
        DiagnosticsProperty<TabController>('tabController', tabController));
    properties.add(IntProperty('currentTabIndex', currentTabIndex));
  }
}

class MaterialPicker extends StatelessWidget {
  final ValueChanged<Color> onColor;
  final Color color;

  const MaterialPicker({Key key, this.onColor, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> colors = List.from(Colors.primaries);
    colors.addAll([white, black, grey]);
    List<dynamic> swatches = colors
        .map<Widget>((dynamic color) => InkWell(
              child: Container(width: 42, height: 42, color: color),
              onTap: () => onColor(color),
            ))
        .toList();

    return Flexible(
      child: SizedBox(
        child: SingleChildScrollView(
          primary: true,
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Wrap(
            runSpacing: 4,
            spacing: 4,
            children: swatches,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<Function(Color)>.has('onColor', onColor));
  }
}

class ColorThumbPreview extends StatelessWidget {
  final Color color;
  final BoxConstraints constraints;

  const ColorThumbPreview({Key key, this.color, this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        constraints: constraints,
        /*
        height: 60,
        width: 100,*/
        color: color,
        child: Center(
          child: Text(
            colorToHex32(color),
            style: TextStyle(color: getContrastColor(color)),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties
        .add(DiagnosticsProperty<BoxConstraints>('constraints', constraints));
  }
}

class ColorTextField extends StatefulWidget {
  final Color color;
  final ValueChanged<Color> onColorChanged;

  const ColorTextField({Key key, this.color, this.onColorChanged})
      : super(key: key);

  @override
  _ColorTextFieldState createState() => _ColorTextFieldState();
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(ObjectFlagProperty<Function(Color)>.has(
        'onColorChanged', onColorChanged));
  }
}

class _ColorTextFieldState extends State<ColorTextField> {
  TextEditingController fieldController;

  bool get valid =>
      RegExp(r'[0-9A-Fa-f]{8}').hasMatch('${fieldController.text}');

  @override
  void initState() {
    fieldController = TextEditingController(
      text: colorToHex32(widget.color).replaceFirst('#', ''),
    );
    fieldController.addListener(_onChanged);
    super.initState();
  }

  @override
  void dispose() {
    fieldController.removeListener(_onChanged);
    super.dispose();
  }

  @override
  void didUpdateWidget(ColorTextField oldWidget) {
    if (oldWidget.color != widget.color) {
      fieldController.value = TextEditingValue(
          text: colorToHex32(widget.color).replaceFirst('#', ''));
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        maxLength: 8,
        textAlign: TextAlign.center,
        controller: fieldController,
        style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12),
        decoration: InputDecoration(
            prefixText: '#',
            counterText: '',
            filled: true,
            contentPadding: const EdgeInsets.all(4),
            border: OutlineInputBorder()),
      ),
    );
  }

  void _onChanged() {
    print('fieldListen... ${fieldController.text} $valid');
    if (valid) {
      final color = Color(int.parse('${fieldController.text}', radix: 16));
      print('_ColorPreviewState.initState... $color');
      widget.onColorChanged(color);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<TextEditingController>(
        'fieldController', fieldController));
    properties.add(DiagnosticsProperty<bool>('valid', valid));
  }
}
