import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_generator/widgets/meme_body_content_widget.dart';

class Template2 extends StatelessWidget {
  final BoxDecoration decoration;
  final Function showImageSourceDialog;
  final String? imageUrl;
  final String memeText;
  final Function setText;

  const Template2({
    Key? key,
    required this.decoration,
    required this.showImageSourceDialog,
    required this.imageUrl,
    required this.memeText,
    required this.setText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MemeBodyContent(
      children: [
        // Text
        GestureDetector(
          onTap: () {
            final controller = TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Please enter meme text:'),
                content: TextField(
                  controller: controller,
                ),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      if (controller.text.trim().isEmpty) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error: No input provided')));
                      } else {
                        setText(controller.text);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            );
          },
          child: Text(
            memeText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Impact',
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),

        // Picture
        SizedBox(
          width: double.infinity,
          height: 200,
          child: DecoratedBox(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GestureDetector(
                onTap: () => showImageSourceDialog(),
                child: imageUrl != null
                    ? (imageUrl!.startsWith('http') ||
                            imageUrl!.startsWith('https'))
                        ? Image.network(
                            imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(imageUrl!),
                            fit: BoxFit.cover,
                          )
                    : Container(),
              ),
            ),
          ),
        ),

        // Text
        GestureDetector(
          onTap: () {
            final controller = TextEditingController();
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Please enter meme text:'),
                content: TextField(
                  controller: controller,
                ),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      if (controller.text.trim().isEmpty) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Error: No input provided')));
                      } else {
                        setText(controller.text);
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            );
          },
          child: Text(
            memeText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Impact',
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
