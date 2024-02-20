import 'dart:io';

import 'package:flutter/material.dart';

class MemeBodyWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final BoxDecoration decoration;
  final Function showImageSourceDialog;
  final String? imageUrl;
  final String memeText;
  final Function setText;

  const MemeBodyWidget({
    super.key,
    required this.globalKey,
    required this.decoration,
    required this.showImageSourceDialog,
    required this.imageUrl,
    required this.memeText,
    required this.setText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RepaintBoundary(
        key: globalKey,
        child: ColoredBox(
          color: Colors.black,
          child: DecoratedBox(
            decoration: decoration,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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
                                          content: Text(
                                              'Error: No input provided')));
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
