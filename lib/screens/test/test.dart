import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RefreshIndicatorExample(),
    );
  }
}

class RefreshIndicatorExample extends StatelessWidget {
  const RefreshIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Text('Test'));
  }
}
