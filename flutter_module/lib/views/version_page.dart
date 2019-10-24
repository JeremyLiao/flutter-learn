import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_plugin/flutter_plugin.dart';

class VersionPage extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<VersionPage> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  ///异步获取sdk版本
  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await FlutterPlugin.sdkInt;
    } on Exception {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Platform Version'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
