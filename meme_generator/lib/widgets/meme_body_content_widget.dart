import 'package:flutter/material.dart';

class MemeBodyContent extends StatelessWidget {
  final List<Widget> children;

  const MemeBodyContent({
    Key? key,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }
}
