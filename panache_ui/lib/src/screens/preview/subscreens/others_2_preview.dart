import 'package:flutter/material.dart';

import '../../editor/editor_utils.dart';

class Others2Preview extends StatelessWidget {
  final ThemeData theme;

  const Others2Preview({Key key, this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: <Widget>[
                    const Text('Button Bar'),
                    ButtonBar(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {/** */},
                          child: const Text('Ok'),
                        ),
                        FlatButton(
                          onPressed: () {/** */},
                          child: const Text('Cancel'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text('MaterialBanner'),
                    MaterialBanner(
                      padding: const EdgeInsets.all(20),
                      content: const Text(
                        "Your card has expired. Update your credit card information.",
                      ),
                      leading: const Icon(
                        Icons.credit_card,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () => null, //_hideBanner,
                          child: const Text(
                            "UPDATE",
                          ),
                        ),
                        FlatButton(
                          onPressed: () => null, //_hideBanner,
                          child: const Text("DISMISS"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Text('Divider'),
          const Divider(
            height: 20,
          ),
        ],
      ),
    );
  }
}
