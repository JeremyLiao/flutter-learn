import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: Text("aa")),
        Text("aa"),
        Text("bb"),
        Container(
          padding: const EdgeInsets.only(
            left: 10,
            top: 10,
            right: 10,
            bottom: 10
          ),
          child: Text("dd"),
        )
      ],
    );
  }
}
