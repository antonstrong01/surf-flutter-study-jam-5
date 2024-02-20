import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MemeTextGestureDetector extends StatelessWidget {
  final Function setState;
  String memeText;

  MemeTextGestureDetector(
      {super.key, required this.setState, required this.memeText});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
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
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Error: No input provided')));
                  } else {
                    setState(() {
                      memeText = controller.text;
                    });
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
    );
  }
}
