import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // can anything else as well
      child: Text('This is page 1'),
    );
  }
}

class PageOneClass extends StatelessWidget {
  const PageOneClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageOne(),
    );
  }
}
