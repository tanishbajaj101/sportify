import 'package:flutter/material.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      // can anything else as well
      child: Text('This is page 2'),
    );
  }
}

class PageTwoClass extends StatelessWidget {
  const PageTwoClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PageTwo(),
    );
  }
}
