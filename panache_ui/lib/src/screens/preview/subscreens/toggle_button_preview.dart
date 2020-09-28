import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../editor/editor_utils.dart';

class ToggleButtonPreview extends StatefulWidget {
  final ThemeData theme;

  const ToggleButtonPreview({Key key, this.theme}) : super(key: key);

  @override
  _ToggleButtonPreviewState createState() => _ToggleButtonPreviewState();
}

class _ToggleButtonPreviewState extends State<ToggleButtonPreview> {
  List<bool> isSelected = <bool>[true, true, false];
  List<bool> isSelected2 = <bool>[false, true, false];
  List<bool> isSelected3 = <bool>[false, false, false];
  List<bool> isSelected4 = <bool>[false, false, true];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: <Widget>[
                    const Text(
                        'Example 1: allows for multiple buttons to be simultaneously selected, while requiring none of the buttons to be selected.'),
                    ToggleButtons(
                      children: <Widget>[
                        const Icon(Icons.ac_unit),
                        const Icon(Icons.call),
                        const Icon(Icons.cake),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                      },
                      isSelected: isSelected,
                    ),
                    const Divider(),
                    const Text(
                        'Example 2: requires mutually exclusive selection while requiring at least one selection'),
                    ToggleButtons(
                      children: <Widget>[
                        const Icon(Icons.ac_unit),
                        const Icon(Icons.call),
                        const Icon(Icons.cake),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected2.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected2[buttonIndex] = true;
                            } else {
                              isSelected2[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected2,
                    ),
                    const Divider(),
                    const Text(
                        'Example 3: requires mutually exclusive selection, but allows for none of the buttons to be selected.'),
                    ToggleButtons(
                      children: <Widget>[
                        const Icon(Icons.ac_unit),
                        const Icon(Icons.call),
                        const Icon(Icons.cake),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int buttonIndex = 0;
                              buttonIndex < isSelected3.length;
                              buttonIndex++) {
                            if (buttonIndex == index) {
                              isSelected3[buttonIndex] =
                                  !isSelected3[buttonIndex];
                            } else {
                              isSelected3[buttonIndex] = false;
                            }
                          }
                        });
                      },
                      isSelected: isSelected3,
                    ),
                    const Divider(),
                    const Text(
                        'Example 4: allows for multiple buttons to be simultaneously selected, while requiring at least one selection'),
                    ToggleButtons(
                      children: <Widget>[
                        const Icon(Icons.ac_unit),
                        const Icon(Icons.call),
                        const Icon(Icons.cake),
                      ],
                      onPressed: (int index) {
                        int count = 0;
                        for (bool value in isSelected4) {
                          if (value) {
                            count++;
                          }
                        }

                        if (isSelected4[index] && count < 2) {
                          return;
                        }

                        setState(() {
                          isSelected4[index] = !isSelected4[index];
                        });
                      },
                      isSelected: isSelected4,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<bool>('isSelected', isSelected));
    properties.add(IterableProperty<bool>('isSelected2', isSelected2));
    properties.add(IterableProperty<bool>('isSelected3', isSelected3));
    properties.add(IterableProperty<bool>('isSelected4', isSelected4));
  }
}
