import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String errorMsg;

  ErrorPage(this.errorMsg);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Text(errorMsg, textDirection: TextDirection.ltr),
        ),
      ),
    );
  }
}
