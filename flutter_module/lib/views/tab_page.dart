import 'package:flutter/material.dart';

class _Page {
  final String labelId;

  _Page(this.labelId);
}

final List<_Page> _allPages = <_Page>[
  _Page('项目1'),
  _Page('项目2'),
  _Page('项目3'),
  _Page('项目4'),
];

class TabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: _allPages.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tab Page'),
          ),
        ));
  }
}
