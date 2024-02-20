import 'package:flutter/material.dart';

class TempatesScreen extends StatefulWidget {
  final Function(int) onTemplateSelected;

  const TempatesScreen({super.key, required this.onTemplateSelected});

  @override
  State<TempatesScreen> createState() => _TempatesScreenState();
}

class _TempatesScreenState extends State<TempatesScreen> {
  int selectedTemplate = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: const Text('Template 1'),
          trailing: selectedTemplate == 1 ? Icon(Icons.check) : null,
          onTap: () {
            setState(() {
              selectedTemplate = 1;
            });
            widget.onTemplateSelected(selectedTemplate);
          },
        ),
        ListTile(
          title: const Text('Template 2'),
          trailing: selectedTemplate == 2 ? Icon(Icons.check) : null,
          onTap: () {
            setState(() {
              selectedTemplate = 2;
            });
            widget.onTemplateSelected(selectedTemplate);
          },
        ),
      ],
    );
  }
}
