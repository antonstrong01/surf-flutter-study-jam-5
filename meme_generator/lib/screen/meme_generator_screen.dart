import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meme_generator/widgets/button_widget.dart';

class MemeGeneratorScreen extends StatefulWidget {
  const MemeGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<MemeGeneratorScreen> createState() => _MemeGeneratorScreenState();
}

class _MemeGeneratorScreenState extends State<MemeGeneratorScreen> {
  String memeText = 'Здесь мог бы быть ваш мем';

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ColoredBox(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DecoratedBox(
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
                      SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: DecoratedBox(
                          decoration: decoration,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Image.network(
                              'https://i.cbc.ca/1.6713656.1679693029!/fileImage/httpImage/image.jpg_gen/derivatives/16x9_780/this-is-fine.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final controller = TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Введите новый текст'),
                              content: TextField(
                                controller: controller,
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    setState(() {
                                      memeText = controller.text;
                                    });
                                    Navigator.of(context).pop();
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
              const SizedBox(height: 100.0),
              Button.text(
                text: 'Get new picture',
                height: 48.0,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
