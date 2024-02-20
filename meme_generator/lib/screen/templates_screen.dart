import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meme_generator/cubit/template_cubit.dart';

class TempatesScreen extends StatefulWidget {
  const TempatesScreen({
    super.key,
  });

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
            context.read<TemplateCubit>().updateTemplate(selectedTemplate);
          },
        ),
        ListTile(
          title: const Text('Template 2'),
          trailing: selectedTemplate == 2 ? Icon(Icons.check) : null,
          onTap: () {
            setState(() {
              selectedTemplate = 2;
            });
            context.read<TemplateCubit>().updateTemplate(selectedTemplate);
          },
        ),
      ],
    );
  }
}
