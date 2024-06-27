import 'package:flutter/material.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // can anything else as well
      child: Text('This is page 3'),
    );
  }
}

class PageThreeClass extends StatelessWidget {
  const PageThreeClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageThree(),
    );
  }
}
