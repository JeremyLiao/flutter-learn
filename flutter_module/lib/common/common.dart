import 'package:flutter/material.dart';

class DefaultPage extends StatelessWidget {
  final String title;
  final Widget home;

  DefaultPage(this.title, this.home);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: home,
      ),
    );
  }
}
